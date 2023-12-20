Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA8681961A
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 02:13:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFl8B-0005YS-Q7; Tue, 19 Dec 2023 20:12:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1rFl81-0005YA-9b
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 20:12:05 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1rFl7y-0006h9-S3
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 20:12:04 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a23350cd51cso416863066b.2
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 17:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1703034720; x=1703639520;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ctqqLCjUMJedl9HiY7O+yU9i6s8H5JTNLSLGDBPVd2U=;
 b=brM9IUXhnvVBWU/n2hzGyWlBY5PB7X3dDZdNRknlyLDcE24km9j8/iPbGTXPqkP/Hk
 Z28aiu0D7EXtbbq5E9zrBCEeN7OqwZayDoI4Yw5vLFLHrvrKH2HeLM7KkcqR9KDOjS2M
 tMnIvxiS/LxiRQNiU6YuTblQcd96CnZwCyzKDbHEXUnb9HO7u1w3vm7pviMe/CqgEwj7
 xybU/a93z7wt3pQtiBovMtS0MLV2tMq8x9rKFjtkRKQ9dqfZc+0UGYnvVozz8B57VUTR
 Ci5e6V+lizqw0nEBAExdGAkh4GYTm/DW3tMxdLenHmwr1uwXhigMZKU1k3T+4gl7baOH
 XZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703034720; x=1703639520;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ctqqLCjUMJedl9HiY7O+yU9i6s8H5JTNLSLGDBPVd2U=;
 b=bvCuX4/0KG8QNPZVcuotAOjr3uo0NvcZcvkBitZnNriQlPpyYCaNuMpYWCgcwvLDzQ
 mKoQRu8SbeUTYNgmWKIX/SIWwSSIlqfmissFoQoy7RcyaH2BS5rUQzWCa2qtANJMARAM
 ZpCUwYN1RJ6qzZNIfjJHERbuD2d8tyUHKRd44Ijqo1f8hgAFRl5aS8Bp9Ba8qGegFz/I
 Tc5R7ir8+nRmY93DDpa76Skk4oVKCAdaIVNT4Rz1yauOf2sIgNXzhO9y0jM6VPSq3hT7
 lhFvshemlgxX/gBvoozQP0SyIjjfrW+CJNfdzZPVBYMyOEIGHbc2bDD8mqNcsI7CKKU9
 e3fQ==
X-Gm-Message-State: AOJu0YwU7Skq02hEbFC62w2MyLLwRym/rWZd1DC/9rV1yfgZQc8Zu6DS
 kPRGktwwvHch7QmzzINa54ofzTzDaM7v2EO5on3yxg==
X-Google-Smtp-Source: AGHT+IGKIj8uXrNof0vFGA9X+W17j685HsTkkajHRE0+zYJy299FZuwTmosxPnICQ5rD/dhlHdWjxfjgrzLYuWec7pc=
X-Received: by 2002:a17:906:dc8f:b0:a23:5f80:a55f with SMTP id
 cs15-20020a170906dc8f00b00a235f80a55fmr2457818ejc.110.1703034719726; Tue, 19
 Dec 2023 17:11:59 -0800 (PST)
MIME-Version: 1.0
References: <20231211071204.30156-1-tomoyuki.hirose@igel.co.jp>
 <CAFS=EckTC5P8X4-cnyF3oB5K1sDCbAeBnwLwpy-aVrAJomt3sw@mail.gmail.com>
 <CAFEAcA9PN43Q5AookacMA8gqtj+ogacetjZLZ7uDcp0Sszq6Zg@mail.gmail.com>
In-Reply-To: <CAFEAcA9PN43Q5AookacMA8gqtj+ogacetjZLZ7uDcp0Sszq6Zg@mail.gmail.com>
From: Tomoyuki Hirose <tomoyuki.hirose@igel.co.jp>
Date: Wed, 20 Dec 2023 10:11:43 +0900
Message-ID: <CAFS=EckjA2odtONDi4tQ4nJV7JMGBDyH007gFnve53bbLCbAsQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] support unaligned access for some xHCI registers
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=tomoyuki.hirose@igel.co.jp; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Dec 19, 2023 at 8:26=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Tue, 19 Dec 2023 at 04:49, Tomoyuki Hirose
> <tomoyuki.hirose@igel.co.jp> wrote:
> >
> > I would be grateful if you would any comments on my patch.
>
> It's on my todo list, but at this point I'm afraid I'm
> not going to be able to get to it before I break for
> the holidays, so it will be January before I can look at
> it. (It's a bit complicated because I'll need to look
> at this patch, at the other suggested patch from the
> past that also tried to address this, at various
> mailing list discussions we've had about the problem,
> and at how the code in general is doing things, so it's
> not a trivial change to review.)

OK, I understand.
Enjoy your holidays!

Regards,
Tomoyuki HIROSE

