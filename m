Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA13481C7EF
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 11:14:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGcXK-00016q-NG; Fri, 22 Dec 2023 05:13:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hans@keasigmadelta.com>)
 id 1rGcXI-00016g-R9
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 05:13:44 -0500
Received: from mail-4018.proton.ch ([185.70.40.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hans@keasigmadelta.com>)
 id 1rGcXF-0007FJ-L7
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 05:13:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keasigmadelta.com;
 s=protonmail3; t=1703240017; x=1703499217;
 bh=elRdefUValYSRDNRRnQSkoJ1Y12ldR872FWwbzOufFQ=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=dufDp7bmCbzlWytAFSwiynyz6qlgl0as+CdbSKfF8c4WfaS1b/yRXPB/ogg1K5a+B
 92TAMMkiBnwPV1+LkHsPmCQM0JYGd3KeTl0uY5M0eKZgAzGjAuFqMbvcSJlebv+ygt
 85fECW4HWRPgsTUjj0CNTuUdmwBlP1vzPEdaALHkjbDJbIJ23caUTRF5Ao9bnO8MEM
 NA+Jicq7hzlKKpZXGjsPWiR6PXAqb5UxQbU3ESghfTwc0wQ46Mvcx767ZOpVOjmPsM
 FR3s0LsFeUTPM9ZspA79Y+BeUpAUcu50qr5vykl7syL0sNdRTjzq85iJb/h7L5WNRv
 vsGVSNBWskyCQ==
Date: Fri, 22 Dec 2023 10:13:15 +0000
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
From: Hans de Ruiter <hans@keasigmadelta.com>
Subject: VIRTIO_GPU_CMD_SUBMIT_3D error feedback?
Message-ID: <8b80ba1d-9f9f-4942-aca8-3a4144ede8d5@keasigmadelta.com>
Feedback-ID: 32757310:user:proton
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha256;
 boundary="------4c4dc484dd02abf77e14645dc46add6dd961e0e08295f7e7759ffaa5fec269c1";
 charset=utf-8
Received-SPF: pass client-ip=185.70.40.18; envelope-from=hans@keasigmadelta.com;
 helo=mail-4018.proton.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------4c4dc484dd02abf77e14645dc46add6dd961e0e08295f7e7759ffaa5fec269c1
Content-Type: multipart/mixed;
 boundary=520176ce19ff36ef0fda89e62c43f05db6f0f747d28d49c1cccae000542c
Message-ID: <8b80ba1d-9f9f-4942-aca8-3a4144ede8d5@keasigmadelta.com>
Date: Fri, 22 Dec 2023 18:13:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Language: en-US
From: Hans de Ruiter <hans@keasigmadelta.com>
Subject: VIRTIO_GPU_CMD_SUBMIT_3D error feedback?

--520176ce19ff36ef0fda89e62c43f05db6f0f747d28d49c1cccae000542c
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi guys,

Is there a way for a client-side driver to know if a VirGL command 
fails? The function virgl_renderer_submit_cmd() does return an error if 
one of the commands fail, but virgl_cmd_submit_3d() ignores the return 
code. It looks like VIRTIO_GPU_CMD_SUBMIT_3D would return a success, 
even if one of the commands in the command stream failed.

As a simple scenario: lets say a shader object creation failed for some 
reason. How would the driver know that it happened and be able to 
provide feedback on why? I know that things such as shader syntax errors 
would be caught before sending the shader code to the host. However, 
it's still possible that a shader object creation would fail.

regards,
Hans



--520176ce19ff36ef0fda89e62c43f05db6f0f747d28d49c1cccae000542c
Content-Transfer-Encoding: base64
Content-Disposition: attachment; name="publickey - hans@keasigmadelta.com -
 4293c311.asc"; filename="publickey - hans@keasigmadelta.com - 4293c311.asc"
Content-Type: application/pgp-keys; name="publickey - hans@keasigmadelta.com
 - 4293c311.asc"; filename="publickey - hans@keasigmadelta.com -
 4293c311.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tClZlcnNpb246IEdvcGVuUEdQIDIu
Ny4zCkNvbW1lbnQ6IGh0dHBzOi8vZ29wZW5wZ3Aub3JnCgp4ak1FWUZocFFoWUpLd1lCQkFIYVJ3
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
--520176ce19ff36ef0fda89e62c43f05db6f0f747d28d49c1cccae000542c--

--------4c4dc484dd02abf77e14645dc46add6dd961e0e08295f7e7759ffaa5fec269c1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYIACcFAmWFYToJEJj9eBbXOsrOFiEEQpPDEdGjNHWNvj1PmP14Ftc6
ys4AAGTbAQCAS4YcJfXeE4lJdJA+vr4GmcA4E6pSbaNW4tvK+lMuuwEAm1zD
kxZL6BNMo43pyHNodrE8t6yOT9o62udYo/4Y/wA=
=pwW9
-----END PGP SIGNATURE-----


--------4c4dc484dd02abf77e14645dc46add6dd961e0e08295f7e7759ffaa5fec269c1--


