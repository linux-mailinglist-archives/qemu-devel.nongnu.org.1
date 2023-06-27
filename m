Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E517A73FE91
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 16:43:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE9tO-0008DB-Di; Tue, 27 Jun 2023 10:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qE9tH-0008Cg-QX
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 10:42:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qE9tG-0005fr-5N
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 10:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687876916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zwrQyjQDy6c+IoBcz6v12K3eYjhm9asSVja2uEuEQFY=;
 b=SNGCB3b6xXH1VWrNSOAn3zWygSN+j9dLKhpCl+g7FlMtj6KymzwaTT6BSDt1ruJ2QUn7A6
 98jap+H9sb1bbEJo12MhN4snNKCDhJXHfSyUPHDzzDreqeG46yBE7rgLDYrxueFfAvhMPt
 0re4WyRlw6yCY51yiG1I/SjKBbQQK1M=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16--mHVqIKiM8KMju44wF4TaA-1; Tue, 27 Jun 2023 10:41:52 -0400
X-MC-Unique: -mHVqIKiM8KMju44wF4TaA-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-53fa2d0c2ebso1995630a12.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 07:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687876910; x=1690468910;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zwrQyjQDy6c+IoBcz6v12K3eYjhm9asSVja2uEuEQFY=;
 b=VYR5XANZVgqj6S4rm41eCfogDFmyC/GT/MOXN/wr2sStjgtiHoI6R4K1sjLvupFWGR
 uJaBlzkJY63sU0dzvM4L9eTWedwjcz0YIYDrqGLfmvFN6sDDx8yYbPU6FIrwWN6D+a3B
 6ZXlSSk38rTtOLQQGC+DHavy8/a0emLERP4UNykOEjoas2Dr+BN1X+V4qxGi5b8GQKFx
 vcD76byFJZ2oUwjTCeA/J/b3TpzRNpkDksmFJOnQRxgZhvY0jrW7RDVEVml1vx9p1CRz
 GlbOrWXvCojieutRzkvdZ1kCk4vm9fQd9eYkXbxEtmaTfcVgKl+LLVDqw2xOa+uJVB2H
 f9Iw==
X-Gm-Message-State: AC+VfDxDHjgUzalDy8ccwN/Oe8ZGlmmIEd7NJIr/mWobhUTOskXO8iH8
 VQeAx4gSw5JtPy1twK4+9b8+eSDkSLpkugr+tMejGyYVecAlpnfQGUcUnLxkZPuwcaG1P+Z9Fxt
 Kzs6pj8pFG7D8K6k=
X-Received: by 2002:a05:6a20:440d:b0:11a:2908:bb5c with SMTP id
 ce13-20020a056a20440d00b0011a2908bb5cmr19985425pzb.28.1687876910117; 
 Tue, 27 Jun 2023 07:41:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7NTah/3/MF//akNieC/JMWkbswigoaJkCyGXv+j5xemo/rbXOw+J8YfQsbYyBPt30qle0NUg==
X-Received: by 2002:a05:6a20:440d:b0:11a:2908:bb5c with SMTP id
 ce13-20020a056a20440d00b0011a2908bb5cmr19985406pzb.28.1687876909718; 
 Tue, 27 Jun 2023 07:41:49 -0700 (PDT)
Received: from smtpclient.apple ([116.73.132.30])
 by smtp.gmail.com with ESMTPSA id
 j13-20020aa783cd000000b00640ddad2e0dsm5569882pfn.47.2023.06.27.07.41.47
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Jun 2023 07:41:49 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: ARI and igb emulation
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230627103454-mutt-send-email-mst@kernel.org>
Date: Tue, 27 Jun 2023 20:11:45 +0530
Cc: akihiko.odaki@daynix.com, Igor Mammedov <imammedo@redhat.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <25A57CF2-5027-48B7-A879-8DE8BDEF60B3@redhat.com>
References: <ACCE3C63-50B6-4310-9DF6-F1BE759F5B1E@redhat.com>
 <20230627103454-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



> On 27-Jun-2023, at 8:09 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Tue, Jun 27, 2023 at 08:02:46PM +0530, Ani Sinha wrote:
>> Hi :
>> I am proposing a patch in QEMU [1] which may or may not break ARI but =
I wanted to give my best shot in making sure I am not breaking anything =
with ARI enabled. I see that your igb emulation code enables ARI with =
its SRIOV emulation. I ran the qtest and avocado tests that are =
mentioned in [2] and they both pass. Is there anything else/any tweaks =
that I should be doing to make sure I am not breaking ARI with igb?
>>=20
>> Thanks for information,
>> Ani
>>=20
>> 1. =
https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg05478.html
>> 2. https://www.qemu.org/docs/master/system/devices/igb.html
>>=20
>=20
> I think that just creates igb. to test ARI you need to add
> igbvf devices. Jason maintains it. But really pls go back on-list.

+Jason
+qemu-devel


