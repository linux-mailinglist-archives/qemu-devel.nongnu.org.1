Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A3D74A69A
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 00:12:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHXBd-0008T9-PF; Thu, 06 Jul 2023 18:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris@laplante.io>) id 1qHXBc-0008T1-T3
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 18:10:52 -0400
Received: from mail-4018.proton.ch ([185.70.40.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris@laplante.io>) id 1qHXBY-0002Qb-Lk
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 18:10:52 -0400
Date: Thu, 06 Jul 2023 22:10:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=laplante.io;
 s=protonmail3; t=1688681443; x=1688940643;
 bh=OfYegLzZKgKXhAfJ/X+pc6Zk/6etksyaxLDLvXsyidI=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=55KJ6lY06jx2EloMlNbN9aYOKeGUkRU1gZbL+u83SP2FWRE6ZxT3dp4nixuKGFhdL
 9MotEr6xurnSQVzgVzEfu8dGqygaDsv2Nd8bhHwnWrc6HUIfCWrlg4KJp5YCz+6TzQ
 A2uhEDXA5HMtoZMDaomuJEs2Fx7M2GDv00b16yuaYHbgp2O4hWT1Lpxbo1lIbf36LF
 ruaXGie9sj9TvALdCCsOSwlJN6J3r3Del3PV3GhUTvBHjIHcWAASggABOEmxV83wQL
 795ojwVDrErT4CbddNtgaNkECSp/v0zeE10LSkt8eMz/1JVz8SV2a6ITw2GRkvskn3
 ZwNHaZpsT+BZg==
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
From: Chris Laplante <chris@laplante.io>
Subject: Addition of qtest_irq_intercept_out_named,
 or modify qtest_irq_interrupt_out?
Message-ID: <v4-CFRWoJDePdhYGwXmcoZ4pJoJVk37oEGjiSx0aN-3K4aBwDF3_5SVTlspGOZnwk9QA7ewsCyGgitkgaxtSLRiqe2euhsY1klbjIdCkHf8=@laplante.io>
Feedback-ID: 43500449:user:proton
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="b1_L024ue0u8dswTsNNFscTTvT38dBMp5MjoPgr4834Os"
Received-SPF: pass client-ip=185.70.40.18; envelope-from=chris@laplante.io;
 helo=mail-4018.proton.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

This is a multi-part message in MIME format.

--b1_L024ue0u8dswTsNNFscTTvT38dBMp5MjoPgr4834Os
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

SGVsbG8gYWxsLAoKSSBoYXZlIGEgdGVzdCBjYXNlIHRoYXQgbmVlZHMgdG8gaW50ZXJjZXB0IGEg
bmFtZWQgR1BJTyBvdXQgaW50ZXJydXB0LiBxdGVzdF9pcnFfaW50ZXJjZXB0X291dCBkb2Vzbid0
IHN1cHBvcnQgdGhpcyBjdXJyZW50bHkuIEkgd291bGQgbGlrZSB0byBzZW5kIGEgcGF0Y2ggdG8g
YWRkIHRoaXMgZnVuY3Rpb25hbGl0eS4gRG9lcyBhbnlvbmUgaGF2ZSBhIHByZWZlcmVuY2UgaWYg
SSBpbXBsZW1lbnQgaXQgaXMgYSBuZXcgZnVuY3Rpb24gKHF0ZXN0X2lycV9pbnRlcmNlcHRfb3V0
X25hbWVkKSwgdnMgYWRkIHRoZSBmdW5jdGlvbmFsaXR5IHRvIHF0ZXN0X2lycV9pbnRlcmNlcHRf
b3V0IGluIHRoZSBmb3JtIG9mIGFuIG9wdGlvbmFsIGFkZGl0aW9uYWwgcGFyYW1ldGVyPwoKVGhh
bmtzLApDaHJpcw==

--b1_L024ue0u8dswTsNNFscTTvT38dBMp5MjoPgr4834Os
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6IEFyaWFsLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDE0
cHg7Ij5IZWxsbyBhbGwsPC9kaXY+PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6IEFyaWFsLCBzYW5z
LXNlcmlmOyBmb250LXNpemU6IDE0cHg7Ij48YnI+PC9kaXY+PGRpdiBzdHlsZT0iZm9udC1mYW1p
bHk6IEFyaWFsLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDE0cHg7Ij5JIGhhdmUgYSB0ZXN0IGNh
c2UgdGhhdCBuZWVkcyB0byBpbnRlcmNlcHQgYSBuYW1lZCBHUElPIG91dCBpbnRlcnJ1cHQuJm5i
c3A7PHNwYW4+cXRlc3RfaXJxX2ludGVyY2VwdF9vdXQgZG9lc24ndCBzdXBwb3J0IHRoaXMgY3Vy
cmVudGx5LiBJIHdvdWxkIGxpa2UgdG8gc2VuZCBhIHBhdGNoIHRvIGFkZCB0aGlzIGZ1bmN0aW9u
YWxpdHkuIERvZXMgYW55b25lIGhhdmUgYSBwcmVmZXJlbmNlIGlmIEkgaW1wbGVtZW50IGl0IGlz
IGEgbmV3IGZ1bmN0aW9uICg8c3Bhbj5xdGVzdF9pcnFfaW50ZXJjZXB0X291dF9uYW1lZCksIHZz
IGFkZCB0aGUgZnVuY3Rpb25hbGl0eSB0byZuYnNwOzxzcGFuPnF0ZXN0X2lycV9pbnRlcmNlcHRf
b3V0IGluIHRoZSBmb3JtIG9mIGFuIG9wdGlvbmFsIGFkZGl0aW9uYWwgcGFyYW1ldGVyPzwvc3Bh
bj48L3NwYW4+PC9zcGFuPjwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OiBBcmlhbCwgc2Fu
cy1zZXJpZjsgZm9udC1zaXplOiAxNHB4OyI+PHNwYW4+PHNwYW4+PHNwYW4+PGJyPjwvc3Bhbj48
L3NwYW4+PC9zcGFuPjwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OiBBcmlhbCwgc2Fucy1z
ZXJpZjsgZm9udC1zaXplOiAxNHB4OyI+PHNwYW4+PHNwYW4+PHNwYW4+VGhhbmtzLDwvc3Bhbj48
L3NwYW4+PC9zcGFuPjwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OiBBcmlhbCwgc2Fucy1z
ZXJpZjsgZm9udC1zaXplOiAxNHB4OyI+PHNwYW4+PHNwYW4+PHNwYW4+Q2hyaXM8L3NwYW4+PC9z
cGFuPjwvc3Bhbj48L2Rpdj4NCjxkaXYgY2xhc3M9InByb3Rvbm1haWxfc2lnbmF0dXJlX2Jsb2Nr
IHByb3Rvbm1haWxfc2lnbmF0dXJlX2Jsb2NrLWVtcHR5IiBzdHlsZT0iZm9udC1mYW1pbHk6IEFy
aWFsLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDE0cHg7Ij4NCiAgICA8ZGl2IGNsYXNzPSJwcm90
b25tYWlsX3NpZ25hdHVyZV9ibG9jay11c2VyIHByb3Rvbm1haWxfc2lnbmF0dXJlX2Jsb2NrLWVt
cHR5Ij4NCiAgICAgICAgDQogICAgICAgICAgICA8L2Rpdj4NCiAgICANCiAgICAgICAgICAgIDxk
aXYgY2xhc3M9InByb3Rvbm1haWxfc2lnbmF0dXJlX2Jsb2NrLXByb3RvbiBwcm90b25tYWlsX3Np
Z25hdHVyZV9ibG9jay1lbXB0eSI+DQogICAgICAgIA0KICAgICAgICAgICAgPC9kaXY+DQo8L2Rp
dj4NCg==


--b1_L024ue0u8dswTsNNFscTTvT38dBMp5MjoPgr4834Os--


