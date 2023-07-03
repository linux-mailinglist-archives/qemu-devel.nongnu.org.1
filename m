Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1910F745D89
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:35:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJf8-0001QP-6o; Mon, 03 Jul 2023 09:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qGJeB-00011b-QT
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:31:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qGJe7-0002Qd-0m
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688391073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KsP5vgjplUfyXaP1AgVSMbLc3ZC6w8ABuXQwyTJ/4nA=;
 b=NSdMAoTeUnurajBl0wSgQFKq2+R1nIeKPTa1ufqMe+hs6CPrTVIJxgF4hMKn3k3N0MPrKY
 sBVEpYpwuO2HHrl812NoQlIZNtr6SoAXp0i4uyHWkW+8Wo9KkPvMN/Y7pujxRuj4I9pMBR
 AWufy9b+JWuqR7xjkuo6XQuoL+d5Spk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-0s3IUZ6BP9G2XlwznCIa8Q-1; Mon, 03 Jul 2023 09:31:12 -0400
X-MC-Unique: 0s3IUZ6BP9G2XlwznCIa8Q-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1b8959fb3c7so10493815ad.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 06:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688391071; x=1690983071;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KsP5vgjplUfyXaP1AgVSMbLc3ZC6w8ABuXQwyTJ/4nA=;
 b=Q3JOqeNMylVzzoP9Cuxjn4dd7zuadFHlT4BWXx4tRINxjgauJvYE4fssR7KtRsmxex
 /jZ4GS81FsdCl/aFx4OzTxyKQUOxW57yW0p97vu42JXWKrvBYzXeWjuev8yxMNGpCuLB
 pxG91XqywgATxR3Jt9vWiGULUz1TUt4koD6RezlnxjX0TLpHGOzQVvVQPeSJB1qAPS0/
 c1EM5N70Hn1wuzp2OUCcjuc9BhbG8bFPUy3XuN7pFHvbUyG6Br0sG6G2CJvRJ6pykRg/
 T7LNj10PkxJASf06PetgCASlxDEPb/qlPMOQ/B6EJiiyTcpKLQtIo5SJ4u4r7HZfIpS+
 /GcQ==
X-Gm-Message-State: ABy/qLbcWI+PX0QgXrWcjhqBO6EplsQVbIHWfYqUdTxwXjlFqQabKD2H
 2RLFaANxR7pc97VDg6KSCKx6btksGfiSl1bR34CAbgu3r5nshlO6clUG8W91Sk+sUPQ5+ksn96n
 VvVH9NHp+wV4BKQU=
X-Received: by 2002:a17:902:d2cd:b0:1b5:64a4:bea0 with SMTP id
 n13-20020a170902d2cd00b001b564a4bea0mr9988197plc.10.1688391071242; 
 Mon, 03 Jul 2023 06:31:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHH5nUv+tPAXlYNtUE4yvrj8hjfPNBpMX0ZqsLtVsX46AMqBCMP4LcpX3vgNYU+SzHk2naFLw==
X-Received: by 2002:a17:902:d2cd:b0:1b5:64a4:bea0 with SMTP id
 n13-20020a170902d2cd00b001b564a4bea0mr9988172plc.10.1688391070914; 
 Mon, 03 Jul 2023 06:31:10 -0700 (PDT)
Received: from smtpclient.apple ([203.212.242.239])
 by smtp.gmail.com with ESMTPSA id
 b13-20020a170902b60d00b001aaecc0b6ffsm15304727pls.160.2023.07.03.06.31.07
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Jul 2023 06:31:10 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v6 5/5] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230702005916-mutt-send-email-mst@kernel.org>
Date: Mon, 3 Jul 2023 19:01:05 +0530
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Julia Suvorova <jusual@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <47F77413-318E-498A-A6C7-B3F8475E4E65@redhat.com>
References: <20230630041937-mutt-send-email-mst@kernel.org>
 <4618EAD1-2862-4288-A881-CA860D04ADB0@redhat.com>
 <20230630043734-mutt-send-email-mst@kernel.org>
 <49B901C6-4819-4A00-8225-39FAA6678F3E@redhat.com>
 <20230630055717-mutt-send-email-mst@kernel.org>
 <FB764864-ADD3-4017-8313-ED40A833A81B@redhat.com>
 <a38e0336-58e5-e796-bd29-0dfc5d1d0e46@daynix.com>
 <bf351f8b-1c8a-8a7a-7f44-17c9ba18f179@daynix.com>
 <DFB3B0B7-1F61-4779-9833-2AF1BA3BDFA6@redhat.com>
 <2ffee496-ec63-ad04-a90b-8c2fadbf3657@daynix.com>
 <20230702005916-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 02-Jul-2023, at 10:29 AM, Michael S. Tsirkin <mst@redhat.com> =
wrote:
>=20
> On Sat, Jul 01, 2023 at 04:09:31PM +0900, Akihiko Odaki wrote:
>> Yes, I want the slot number restriction to be enforced. If it worries =
you
>> too much for regressions, you may implement it as a warning first and =
then
>> turn it a hard error when the next development phase starts.
>=20
> That's not a bad idea.

This is with just the warning - the device still gets added:

(qemu) netdev_add socket,id=3Dhostnet1,listen=3D:1234
(qemu)  device_add =
e1000e,netdev=3Dhostnet1,mac=3D00:11:22:33:44:03,id=3Dnet1,bus=3Dpci.6,add=
r=3D0x2.0x5
warning: PCI: slot 2 is not valid for e1000e, parent device only allows =
plugging into slot 0.
(qemu) info network
igb.0: index=3D0,type=3Dnic,model=3Digb,macaddr=3D52:54:00:12:34:56
igb.1: index=3D0,type=3Dnic,model=3Digb,macaddr=3D52:54:00:12:34:57
net1: index=3D0,type=3Dnic,model=3De1000e,macaddr=3D00:11:22:33:44:03
 \ hostnet1: index=3D0,type=3Dsocket,

device_remove won=E2=80=99t be able to remove the nic unless guest =
cooperates.=


