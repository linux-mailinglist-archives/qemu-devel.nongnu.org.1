Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3C27C94AA
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 15:03:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qreHc-0002r0-9r; Sat, 14 Oct 2023 09:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edmund.raile@proton.me>)
 id 1qraet-00021T-BS
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 05:10:07 -0400
Received: from mail-4318.protonmail.ch ([185.70.43.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edmund.raile@proton.me>)
 id 1qraeg-00031A-Ru
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 05:10:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1697274592; x=1697533792;
 bh=HSqEJUnda3/8x7gQqyJvp1gJz5/bxDGoZZneaKctwpE=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=GDnrbIVgdJ78gjcx2gV67/dGP/K4voG8+FQhqgujxEiPZ3s+cn84ZqQ9NPGQ5FZAu
 1aVm4LBIc4pIgySfnXB7uO3u1fuwJkM5zPoc50LVXCVWy2wyFfE/FA6UedkaB5TfUj
 UkiiYuxmK1IhWYZYNSjfl38Sb0DnyYMpXOGvCv2Pi+AtYsXRa7OoNQTu5anc2CQLze
 mkWmEZmABmdIoWkoJnbM/LMoIPq1a7qTr76aoFFge4UbKLUMQcYM6yKJ3A+k3vtM3y
 2+PIkibekDJ1TBtfYQ44C6Cpa4UvHLyE5Fkm+MtmvJIi+2/mIWU9B6JgfPefbKT5x/
 bozAB6QbROmLA==
Date: Sat, 14 Oct 2023 09:09:45 +0000
To: alex.williamson@redhat.com
From: Edmund Raile <edmund.raile@proton.me>
Cc: dongwon.kim@intel.com, kraxel@redhat.com, marcandre.lureau@redhat.com,
 qemu-devel@nongnu.org, Edmund Raile <edmund.raile@proton.me>
Subject: [PATCH for-8.1] vfio/display: Fix missing update to set backing fields
Message-ID: <20231014090912.43842-1-edmund.raile@proton.me>
Feedback-ID: 45198251:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.43.18; envelope-from=edmund.raile@proton.me;
 helo=mail-4318.protonmail.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 14 Oct 2023 09:02:15 -0400
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

Hi,
I can confirm that the patch indeed fixes the issue.
Kind regards,
Edmund Raile

Tested-by: Edmund Raile <edmund.raile@proton.me>


