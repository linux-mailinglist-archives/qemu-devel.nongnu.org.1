Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6D17F6BE0
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 07:03:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6PG7-0000xv-NQ; Fri, 24 Nov 2023 01:01:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r6PG5-0000xj-PG; Fri, 24 Nov 2023 01:01:45 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r6PG4-0001He-91; Fri, 24 Nov 2023 01:01:45 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1cfa5a7a9ecso816785ad.2; 
 Thu, 23 Nov 2023 22:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700805702; x=1701410502; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y+9Di1KyRkYhulHS29cMnclnv49NL8sar+FxYaYbeOg=;
 b=bn0NJBGdaEbFFHdCVEdDyzVfvRmZM/W+VqLztYwYuGkbHwUqAJ7TBcKbGI6UZP1Nno
 P5MSqJGgqdhXaoHg4eI2gGooKXipb4pFg9Eg3gytg/bLkD11pSskGkoI5LjCWwurHlSJ
 M7NSc5t9hENn2O4mimDVIZPYsPw0OHHA0tRx2RVA2JesF6UZPR2HofMiKE+AwqxwGiDh
 HwjIezwWeXmH6snZrGN1m1QcmabXKgit2xD9ngF2FtWG2eQ+CVa+24KvtDgYvEnZPsYM
 ux56wxGm57KLhFyUxkxXg1CHr5WgdnXk/e1W6wQedL2wvCgZA4hZY7K8oTFTy8CzyJd9
 lE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700805702; x=1701410502;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=y+9Di1KyRkYhulHS29cMnclnv49NL8sar+FxYaYbeOg=;
 b=vGbhTKlDFIweoVSFvrpeTImGZqkNxmnb/I7XJzc+a0uCWHNKOAuQx61eWTFXkugDjw
 Kz1c72d49ZCbts1QTMzvwkHQiyqvuRGs5Zfj1kOwYe2fVGfgb3S3bQtJnmdLQS9zWv8T
 2LxawJx7EPBT7kLnox40nnY8krW/Qk6cEja1NeouKlF0yE8YSwfVGIHJ46Y2PGD4I7ob
 Xt+j+h4rfbZUwA8RLxYo/uQMrgibd2IAwPqFGWsB0Th9twvSqp9Wen5DzG6av7HEmGQ6
 52Y4qh4TFyB7B0uyRzwkDrlOkpAOvBhXzn3U0qNDGx4Q4nAi3Emdu1U6USzYca79EqoP
 iguw==
X-Gm-Message-State: AOJu0YyUdbxgsgL12hIf37PkHBXVvUs+HXIvIhosnr68NqiM5Zul/Njw
 v/H1f4hEf+keQ/dluBdujW4=
X-Google-Smtp-Source: AGHT+IHf3nT36JqSxA42uT0gKzNzXgcHKsng5v5tbWEdGC/TZF4DGhs2aEpY1ych7S4hnJFmgX4C1w==
X-Received: by 2002:a17:903:22d2:b0:1c9:c6f4:e0c3 with SMTP id
 y18-20020a17090322d200b001c9c6f4e0c3mr1814419plg.62.1700805702130; 
 Thu, 23 Nov 2023 22:01:42 -0800 (PST)
Received: from localhost ([1.145.239.154]) by smtp.gmail.com with ESMTPSA id
 t8-20020a170902bc4800b001cc131c65besm2329433plz.168.2023.11.23.22.01.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Nov 2023 22:01:41 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Nov 2023 16:01:19 +1000
Message-Id: <CX6TAMGT9JI5.34UBPLT94GUP4@wheely>
Cc: <chao.p.peng@intel.com>, "Paolo Bonzini" <pbonzini@redhat.com>, "Daniel
 Henrique Barboza" <danielhb413@gmail.com>, "David Gibson"
 <david@gibson.dropbear.id.au>, "Harsh Prateek Bora"
 <harshpb@linux.ibm.com>, "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>
Subject: Re: [PATCH] hw/ppc: Improve build for PPC VFIO
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, "Zhenzhong Duan"
 <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20231123060109.131904-1-zhenzhong.duan@intel.com>
 <dd2db398-908a-46a8-b02b-8418956462cb@redhat.com>
In-Reply-To: <dd2db398-908a-46a8-b02b-8418956462cb@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
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

On Thu Nov 23, 2023 at 5:33 PM AEST, C=C3=A9dric Le Goater wrote:
> On 11/23/23 07:01, Zhenzhong Duan wrote:
> > VFIO is not a required subsystem for the pseries machine but it's
> > force enabled currently. When --without-default-devices is used
> > to drop some default devices including vfio-pci, vfio core code
> > is still kept which is unnecessary.
> >=20
> > Introduce a stub file to hold stub functions of VFIO EEH hooks,
> > then vfio core could be compiled out.
> >=20
> > Suggested-by: C=C3=A9dric Le Goater <clg@redhat.com>
> > Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>
>
> Nick,
>
> I will take this patch through the vfio tree if that's OK for you.

That's fine, thank you.

Thanks,
Nick

