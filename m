Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF72682D448
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 07:47:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPGkM-0007ZJ-Fg; Mon, 15 Jan 2024 01:46:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicholas.h.briggs@gmail.com>)
 id 1rPGjw-0007WR-Uf
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 01:46:32 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nicholas.h.briggs@gmail.com>)
 id 1rPGjv-00009N-9Z
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 01:46:32 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d51ba18e1bso71524425ad.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 22:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705301189; x=1705905989; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=skcnIhNzMw9m0Z5x32CoefWLyexHG9fJo9WFCHX9e6k=;
 b=M63kmDnABITlK4+hflV8vSt5YusJGKXrTKIh0sf86lPfptIAXi/+STF6TQHb+JLy5n
 pyoQzE/lKsviJYXeVvUovadIgmOeu6DOyMUbD9h1YfmgNn0e4XrgboP9lsBnV9IInAaQ
 1Jq0nLzbHDrfgZW7opfjmUYnOouXYSkNDuuxQyw96JSShh44Yd1es2e0NeGGgv/qnSuv
 pExpbRHoZvTCOvB9iu7NM7MGHfiPsnjeQJTS1FTxhZhHwaHe+gPU87kdYFb4FBSwrqin
 FTGZQstqUWugPl+VuyJk1JUSpnhZze7aq0oB5/i3UckRKg7WS0ZQZGxK0ilhSWSHeL8+
 s72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705301189; x=1705905989;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=skcnIhNzMw9m0Z5x32CoefWLyexHG9fJo9WFCHX9e6k=;
 b=SifSwZOtYBlvNZicZdhtUbhSTE6zkgX/zqPABbB80JzujNVTFrQFfNpvq+hbKLvO6P
 aa1Qn/R+HWn7lhZ/OEjjBMamL/BTBz0DE0kwov2Sp5oB4uj3XhiE6ebLefVxFtUo7n/s
 cuCY9l1MqdppQyCCVbYOHNTNB1hhQx4/88oz15j9IYe/XJKyL+f98tUq+Kqbdp+yF0+P
 l2JNGQGbPzPVtW4BD3I6gDV8DjXuYZ+birta95oob0DteMd2ahVUyYv1J9Ulc4cA3zwM
 mMk3u7MKuJiyF3AAxQ/QPlpMCEM3hTYNx6AtGSQZt1Jx3MsXJWvDgMVwipk+DbgpUofy
 zvfw==
X-Gm-Message-State: AOJu0Yx6nWXr4999rV9eau+vZeTIsH9F50P8lV/el5xnqhHdaOQQ7FmE
 jKvwZCOXSI8Z+2UyFDqixy8=
X-Google-Smtp-Source: AGHT+IHfSkX8kJ1pcx0Tlfs1GP24AkWUVRlpC+Lc1Yer40nzkF4q8FVxXmOMQabV2aWHKBzVWeIDuA==
X-Received: by 2002:a17:902:c281:b0:1d0:476f:b2ba with SMTP id
 i1-20020a170902c28100b001d0476fb2bamr5255999pld.50.1705301189556; 
 Sun, 14 Jan 2024 22:46:29 -0800 (PST)
Received: from smtpclient.apple ([2602:24a:de47:d2c0:c4e0:f575:2552:125c])
 by smtp.gmail.com with ESMTPSA id
 j17-20020a170902c3d100b001d4c8eb6d8esm6959241plj.294.2024.01.14.22.46.27
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 14 Jan 2024 22:46:28 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.15\))
Subject: Re: [PATCH 1/2] migration/rdma: define htonll/ntohll only if not
 predefined
From: Nick Briggs <nicholas.h.briggs@gmail.com>
In-Reply-To: <ZaS2JHceJNi-GX02@x1n>
Date: Sun, 14 Jan 2024 22:46:26 -0800
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@fujitsu.com>,
 Fabiano Rosas <farosas@suse.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BBFC9568-3F3C-43A6-B0B0-B4AF75A39FDC@gmail.com>
References: <65a04a7d.497ab3.3e7bef1f@gateway.sonic.net> <ZaS2JHceJNi-GX02@x1n>
To: Peter Xu <peterx@redhat.com>
X-Mailer: Apple Mail (2.3654.120.0.1.15)
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=nicholas.h.briggs@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Thank you.

Yes, with those two patches applied I have compiled qemu on Solaris 11.4 =
running on a SPARC-T4-1 (sun4v) system to emulate a single target: an HP =
PA-RISC.

> On Jan 14, 2024, at 8:35 PM, Peter Xu <peterx@redhat.com> wrote:
>=20
> On Thu, Jan 11, 2024 at 01:20:17PM -0500, Nick Briggs wrote:
>> Solaris has #defines for htonll and ntohll which cause syntax errors
>> when compiling code that attempts to (re)define these functions..
>>=20
>> Signed-off-by: Nick Briggs <nicholas.h.briggs@gmail.com>
>=20
> I left the other QGA patch for QGA maintainers, assuming this will =
enable
> solaries build for qemu itself alone.
>=20
> Queued this one for migration-staging.
>=20
> Thanks,
>=20
> --=20
> Peter Xu
>=20


