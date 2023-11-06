Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA04F7E1BC8
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 09:17:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzumI-0000RR-Fx; Mon, 06 Nov 2023 03:16:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qzulv-0000LX-FT
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 03:15:50 -0500
Received: from mout.kundenserver.de ([212.227.17.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qzult-0007xj-Jp
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 03:15:47 -0500
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue108
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MvsR7-1rJNQf1Elr-00sxME; Mon, 06
 Nov 2023 09:15:42 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 0/4] Q800 for 8.2 patches
Date: Mon,  6 Nov 2023 09:15:37 +0100
Message-ID: <20231106081541.53688-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:b8aMe7HRoEH2FF7r+hBdppwZySWJ5ISW9R7PCco4ZTS+TbwTRCK
 vTH2w2rOkXD8oWVJDN4MLfb1TwBPh9rZArtArj0jmQbFjDRQIiPsnOqNyGl3fKiB8Q82R7j
 7Tk+sCE9LSfsBj7ZTzvMBWu0BSttYzI7BFCa1hC2lPdhwBjUyNV00bfs72wBsLWnB0dc+Ra
 GAX32ZYE5O1saBaHT7DQw==
UI-OutboundReport: notjunk:1;M01:P0:Kir6RMs6OU8=;M7Txy+d+z2ye7Qh/mgPS5THEnHE
 J1wLqLWgU2r+42D6NSzQEo84Gr7ID3YT3S2qmRroQjGDkV8J5CbCqrLB8k0hj3Vl2RMRfXn4s
 R/0TPqdEKp/pD58tUFxBsuTvFEjSCMil4QODAkLrw2mEmkNUed3fTRCNaPSpPx78XFNkkg4PE
 gQ/81Zm2nXEgvxq8eWymospTYG0jwX6Wkwe5eGKp1/lYX9yGlnK5RelFO/UyEtsR0WI7y0DHi
 BJHpK0P8d6jeGOFt3CRMB8ID92xOKfFu2i+DoBK9iG38W3499RhTPYgtzglfWXS/UFCau+uPV
 2LTJqj6+eHiMOGd4at4dRYIcs+2HMTMA1NBM+m2BuCQBCOAg1HxQvkxbNETYI+M+u+bJhpixJ
 6VhSsC5IlWnUo138xkkbG/3+DjeQQQ3zAl7saz9gdKlrdMc4m7HGEpLlunNo+qdcjAd59w6Qi
 oeHNT3u8xjA7C2Vr3cuSG8l/lUDz7QvjvBpv/VR5OyTJv+nFZwOunYsHPAdSK3bJaYXOaTOp2
 oP+HEcZgQn2wJgrJCKbzA6Prv9kJv/UKuupFa28Ug4Gg3f9cNl6/MxnafKWGHk9W/D4R5kO6u
 yVjbsJJRukZ9NMvQdoj8S3vnLGrf53IT6v9mMK+UH/gV/3T+476R5oRkOp/Q4klWjoZW3yti0
 RUK960VqntkU5FPYwLgR1VBdXwIfjPVnvw75XjLGUAhuz3StkBu59WnE/3slJr35BnqxzAILq
 agxpoyfPNbnXKQ/IRUVMxL9TBAqMcJ6uuG1AQNQfkGjX4q6GGR/OIgGztQ7vIgGqEX7/jVI2z
 LX8OcsMs9bPTVyomCKKbzE3fHfxiN4s13A3bEUT7CWXk7y6+JPJLV4wSrM+vjDnLlrILWncYe
 SOEbkxmDMke+mTg==
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

The following changes since commit d762bf97931b58839316b68a570eecc6143c9e3e:

  Merge tag 'pull-target-arm-20231102' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2023-11-03 10:04:12 +0800)

are available in the Git repository at:

  https://github.com/vivier/qemu-m68k.git tags/q800-for-8.2-pull-request

for you to fetch changes up to 95f3943210416e054751bc230d4cec7d87995525:

  macfb: allow reads from the DAFB_LUT register (2023-11-05 15:48:36 +0100)

----------------------------------------------------------------
Q800 pull request 20231106

macfb: A/UX fixes for colour LUT

----------------------------------------------------------------

Mark Cave-Ayland (4):
  macfb: don't clear interrupts when writing to DAFB_RESET
  macfb: rename DAFB_RESET to DAFB_LUT_INDEX
  macfb: allow larger write accesses to the DAFB_LUT register
  macfb: allow reads from the DAFB_LUT register

 hw/display/macfb.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

-- 
2.41.0


