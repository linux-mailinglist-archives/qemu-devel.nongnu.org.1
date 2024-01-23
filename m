Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A90883888F
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 09:11:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSBqa-0001OO-QH; Tue, 23 Jan 2024 03:09:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rSBqT-0001N8-8Y
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 03:09:21 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rSBqR-0006mb-H1
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 03:09:20 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-55a45a453eeso5000169a12.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 00:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705997356; x=1706602156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=OI9IIjpMVEfwc1WY0Um4KoqbJRq6fNOPWlBoGCOF4Ks=;
 b=OEZzMVJoLtI0rwK69hU0xHvZOfiTnakZF1cchWfrOrc2koYGkYmGJ6fS3ZXmNv+5XH
 h96xuRm7fETWko38bvD5K3nAveTnEWFz0jyIeNFR89grlcey0x8/5UKg2RsUuiA9jQIL
 eXw4Bu0PfmUZQxbQp0zMoSZPDmRFjjVdVP5lc9fM9WaatBk67gz/fEe8ChC6xahHwD6R
 e8N4eG7M58pSJth6WOFfXruXINxqkz15r+egOFYwJwo6GOQoAYj3YXjxA64WEx5628gP
 1lAp4Cq/MRkBiqkOktt7JKlzIypHNnOpdrYbkltYKjUpZETxv/nlM1/ahRpK/3JMkKlx
 guTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705997356; x=1706602156;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OI9IIjpMVEfwc1WY0Um4KoqbJRq6fNOPWlBoGCOF4Ks=;
 b=Sh5hlw5E0hUGN0/L5fdPeDW9gRZ+N6nJu32pKIwMdavFZ9lxVPTz+jW526if3oBDMl
 SGILB1i8tuCp0OJFAV5gX/rLOgsXdROzs6gyO7GGHkl1Uk0/3RU45UsJdanEKwIJlWAK
 Se0iuLBYd+FKWw3Aj2e3aSzCj8wkhHX2/64SGk9v4L3XwYn/X3MY7pmT2kIRDQ65e66C
 AGx40EkQHJs1l/anTzpIsZHpa9tnk4b6RX0edHtaWUwUlM0ZVAHLLGm5Uhrjh38dLrX9
 tqERLFCg0B3HLyaDkTaMoFE6Gmafpt6/RNeAUXMVuXj3DcsHmNc3w+EH369C++q3Rr1d
 agaA==
X-Gm-Message-State: AOJu0YwXbTS1cCw8eHp8GR8rwxry52dX5wEXLXJnW0pJutcroCYdgQ5K
 vO4OuR3bGXFkC0aXvjh656Np3DkW2mXksAxHJ99m+b5hxPHyNNwcNLKcpqMz1hD+/UGcBMbhecq
 1smM=
X-Google-Smtp-Source: AGHT+IHmMLp+ZhxB8ISNo6h5eUk9FklBXro+ZVR3fty970heZ1ik4XrXOMFmKPND3f66yumr/bPwjg==
X-Received: by 2002:a17:906:3e08:b0:a28:fe51:8e8d with SMTP id
 k8-20020a1709063e0800b00a28fe518e8dmr2874474eji.80.1705997356474; 
 Tue, 23 Jan 2024 00:09:16 -0800 (PST)
Received: from localhost.localdomain (adsl-138.37.6.1.tellas.gr. [37.6.1.138])
 by smtp.gmail.com with ESMTPSA id
 tb21-20020a1709078b9500b00a2f24da8baasm5794069ejc.39.2024.01.23.00.09.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 00:09:16 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Subject: [PATCH 0/2] hw/block/block.c: improve confusing error
Date: Tue, 23 Jan 2024 10:09:11 +0200
Message-Id: <cover.1705938003.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

In cases where a device tries to read more bytes than the block device 
contains with the blk_check_size_and_read_all() function, the error is 
vague: "device requires X bytes, block backend provides Y bytes".

This patch changes the errors of this function to include the block
backend name, the device id and device type name where appropriate.

Manos Pitsidianakis (2):
  hw/core/qdev.c: add qdev_get_human_name()
  hw/block/block.c: improve confusing blk_check_size_and_read_all()
    error

 hw/block/block.c         | 25 +++++++++++++++----------
 hw/block/m25p80.c        |  3 ++-
 hw/block/pflash_cfi01.c  |  4 ++--
 hw/block/pflash_cfi02.c  |  2 +-
 hw/core/qdev.c           | 10 ++++++++++
 include/hw/block/block.h |  4 ++--
 include/hw/qdev-core.h   | 15 +++++++++++++++
 7 files changed, 47 insertions(+), 16 deletions(-)


base-commit: 09be34717190c1620f0c6e5c8765b8da354aeb4b
-- 
γαῖα πυρί μιχθήτω


