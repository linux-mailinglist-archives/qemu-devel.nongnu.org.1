Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEFE7CB7A7
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 02:52:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsYJ2-00029t-Iw; Mon, 16 Oct 2023 20:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hans@keasigmadelta.com>)
 id 1qsYFo-0001hL-C9
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 20:48:12 -0400
Received: from mail-4022.proton.ch ([185.70.40.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hans@keasigmadelta.com>)
 id 1qsYFk-000241-JB
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 20:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keasigmadelta.com;
 s=protonmail3; t=1697503684; x=1697762884;
 bh=Bqa6R9KGRueh6YRL2VCRgZ9fFDTerZGQDqZEw5vvLYw=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=rkC0CIZJGRK8TfqRAXyW6UFl6ADaHWJfs+H+hoc2JbVwysuuDU90ggdcvdr+Nm1bX
 BddYVfP69NlH01Vw77/OiQypZ38DV0i4gwoYRAgyfnRVJCe7xwol8ra6wQre+GQ4nY
 wbGEFjOCk62q8CzZi4y5gacrjwVFqXS3M2ENDr9gDzPJPtHeuaBbW6Jp10Qj8AbO6L
 1uuAQw3ajMHRJDyQrIVORoBQH+gWdBeS01142a0W6iqhEhoz8RfqQ1O8rJiIkt2suZ
 25KXW02MKNlMMN4U5BZYAR5mo5LByZu9mubvmt/knlTzPHDfPvnfyzFV7sIIi2bNnP
 ljLmmwz8B12/A==
Date: Tue, 17 Oct 2023 00:48:00 +0000
To: qemu-devel@nongnu.org
From: Hans de Ruiter <hans@keasigmadelta.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Subject: QEMU Virtio GPU features status & roadmap?
Message-ID: <65466251-5c0c-90d0-c482-29ebc4e16a20@keasigmadelta.com>
Feedback-ID: 32757310:user:proton
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha256;
 boundary="------bbc313b4ab2ac8239ff65407c0162158432055a95f0116aa574d10dd7698bcfb";
 charset=utf-8
Received-SPF: pass client-ip=185.70.40.22; envelope-from=hans@keasigmadelta.com;
 helo=mail-4022.proton.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 16 Oct 2023 20:51:30 -0400
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------bbc313b4ab2ac8239ff65407c0162158432055a95f0116aa574d10dd7698bcfb
Content-Type: multipart/mixed;
 boundary=1c8a27eb550a8ff1ccdbe9972a9f792615d68a0aeaab36ceacb79cf47789
Message-ID: <65466251-5c0c-90d0-c482-29ebc4e16a20@keasigmadelta.com>
Date: Tue, 17 Oct 2023 08:47:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
From: Hans de Ruiter <hans@keasigmadelta.com>
Subject: QEMU Virtio GPU features status & roadmap?

--1c8a27eb550a8ff1ccdbe9972a9f792615d68a0aeaab36ceacb79cf47789
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I'm working on Virtio GPU drivers for AmigaOS, and would like to know 
what features are currently stable enough to use. Looking at the master 
QEMU branch, both Virgl and blob resources are supported, but NOT at the 
same time. Is the ability to use both simultaneously coming soon?

Also, what's the state of Venus/Vulkan support? Surveying various 
forks/branches, it looks very experimental and subject to change.

I have the added difficulty that the AmigaOS Picasso96 driver API 
expects direct CPU access to all of VRAM, and likes to peek/poke 
directly into the bitmaps. That's clearly not possible without blob 
resources, or shared memory (not entirely sure what the shared memory 
feature is for). This is why I want to know what features are stable or 
coming soon.

regards,
Hans


--1c8a27eb550a8ff1ccdbe9972a9f792615d68a0aeaab36ceacb79cf47789
Content-Transfer-Encoding: base64
Content-Disposition: attachment; name="publickey - hans@keasigmadelta.com -
 4293c311.asc"; filename="publickey - hans@keasigmadelta.com - 4293c311.asc"
Content-Type: application/pgp-keys; name="publickey - hans@keasigmadelta.com
 - 4293c311.asc"; filename="publickey - hans@keasigmadelta.com -
 4293c311.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tClZlcnNpb246IEdvcGVuUEdQIDIu
Ny4xCkNvbW1lbnQ6IGh0dHBzOi8vZ29wZW5wZ3Aub3JnCgp4ak1FWUZocFFoWUpLd1lCQkFIYVJ3
OEJBUWRBUEFDckNETHVSSkZPbVl3Mm02a3FxK3VOTlVVbloxYzFlUU5hCmo4TUxZL25OTDJoaGJu
TkFhMlZoYzJsbmJXRmtaV3gwWVM1amIyMGdQR2hoYm5OQWEyVmhjMmxuYldGa1pXeDAKWVM1amIy
MCt3bzhFRUJZS0FDQUZBbUJZYVVJR0N3a0hDQU1DQkJVSUNnSUVGZ0lCQUFJWkFRSWJBd0llQVFB
aApDUkNZL1hnVzF6ckt6aFloQkVLVHd4SFJvelIxamI0OVQ1ajllQmJYT3NyT2I2Y0EvalhkMUhk
V2paQkV6WUNqCjlmUitEWm5DREplbjNRYzhNRzU0TW9CZHZLZ0FBUDlvM3dqMGhpVXh4RXJhUjhs
U0tZMGhOVnBwR2Nrb0pLeUIKRlRXR25VRU9BODQ0QkdCWWFVSVNDaXNHQVFRQmwxVUJCUUVCQjBE
NS9xRWphWUU4MWs4R095OFF1RmNGbGZmWgpWbEw2M1ZsMThWZ3pONXJnSWdNQkNBZkNlQVFZRmdn
QUNRVUNZRmhwUWdJYkRBQWhDUkNZL1hnVzF6ckt6aFloCkJFS1R3eEhSb3pSMWpiNDlUNWo5ZUJi
WE9zck9zZXNBL2p5a0taQksxZ3JIVldWalFCbC9iMlVRVk1RVUhDUDkKdjdsM1p4QkZxaGlXQVFD
UjdjSWtrZ1ZvL1JXUzh5NG9MUXdZNjRQM0tzazRYOHpBZHBjOVl3MDhEQT09Cj0zL0llCi0tLS0t
RU5EIFBHUCBQVUJMSUMgS0VZIEJMT0NLLS0tLS0=
--1c8a27eb550a8ff1ccdbe9972a9f792615d68a0aeaab36ceacb79cf47789--

--------bbc313b4ab2ac8239ff65407c0162158432055a95f0116aa574d10dd7698bcfb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYIACcFAmUt2cAJkJj9eBbXOsrOFiEEQpPDEdGjNHWNvj1PmP14Ftc6
ys4AABxJAP0Q6JNJzQjGfNOkpXgwtVN8/qVbgbqlClNAWKubAiFIqwD8DRG/
1E1+HsKHOg0K8Owz0x5kMN/5l53T2ckWAfQu+wE=
=JDWf
-----END PGP SIGNATURE-----


--------bbc313b4ab2ac8239ff65407c0162158432055a95f0116aa574d10dd7698bcfb--


