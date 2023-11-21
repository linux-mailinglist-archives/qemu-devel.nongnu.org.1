Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F135A7F32EE
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 16:58:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5T7j-0004Wv-Ko; Tue, 21 Nov 2023 10:57:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r5T7e-0004Vk-2e
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 10:57:10 -0500
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r5T7c-0002e2-Ba
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 10:57:09 -0500
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1f5d7db4dcbso1819703fac.2
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 07:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700582226; x=1701187026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=TlgLjf5qP29U9hK8NycSeILzBTq1aaELwhHHfZa/l88=;
 b=vjfhssMXx1VkY5Zw8xWpybSD93RYfEZO3pOkVcVyWtQpvpQNzfSeKRMsbgnsLp+FBW
 jOyO7/aR+3JXP/Nvwd+eu3RPbWFbKtwEPxULh57sXU9onK/M5uy5/vguvn+W/Nw8wy9H
 QJKPzs+bMMxqsg5QTHdWCdm2eOYPNLioDZsYg9ON8W8lp9GojlA+RRtF25Riar4oY/aM
 PYlSnU2zWp2af6xTvAG49rEgYqtASJkTZJlmZ5NvpOzbWZmxg67JIkeovnj9DBU75TJ6
 7MXTLQ8ymdJNZg+LJwMwbGW5AiiLJiZWr/9B5aaxLSrfwidM1PcyopYB+k7rfKYD5ZAt
 8t9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700582226; x=1701187026;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TlgLjf5qP29U9hK8NycSeILzBTq1aaELwhHHfZa/l88=;
 b=TzsgEWkBHr+9DDSF4/NWJoGE0pBmt+PT0YrV+8APQjTf6myrs4Fqn6IOtf0j2HxOHJ
 8sLeZ3zNwbCAwad0xRVyG+Nbv7JMNwY7HbFl7sehvfwhU2mCR5aDa6vFVmw9BuQoD+Tn
 4eL25SA/wg3y7KVp9Q+A4QjdPaPC8VpXBXAUNs3YuPCaSNvsLlPkumFVX34hFCNlGq/Z
 uuZzrHsyVU5I/jTTOHcPMsOu9xM4xz7g4PWvSwCcseqlfttuSvw7tsvtoVL8kqajOMME
 hHSZYrs2yg3s3CAitsY4s3eKTeCm7rRDTv34qIdnny5ITFvFXQedQbwYTEA38ni8P5WD
 I4IA==
X-Gm-Message-State: AOJu0YzBJbijj2Ry3I0KaoaacH9uziidiEeb/AeMhEkzvQCNUu7D3GGL
 PMmOpcF16F2K/TVf5mXeCVo9SisZcL39kyMjAcC3Zg==
X-Google-Smtp-Source: AGHT+IEXBwzebjlD4bncw0DZ1g8onSJE3Ayj+x6C3adDzxuyjztP3/w2jIEMPelrIZjJaW6pzbrJpw==
X-Received: by 2002:a05:6870:35cb:b0:1c3:91b9:e1e7 with SMTP id
 c11-20020a05687035cb00b001c391b9e1e7mr13514249oak.21.1700582225979; 
 Tue, 21 Nov 2023 07:57:05 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 n22-20020a9d4d16000000b006cd0a04b56esm1543574otf.56.2023.11.21.07.57.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 07:57:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] linux-user late fix
Date: Tue, 21 Nov 2023 09:56:56 -0600
Message-Id: <20231121155657.798505-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2c.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

The following changes since commit c14ae763d548842c6abd1afaf5dc7ce7322ed901:

  Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2023-11-21 06:25:14 -0500)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-lu-20231121

for you to fetch changes up to 82d70a84c8ee42ef969a9cfddc0f5b30b16165f5:

  linux-user: Fix loaddr computation for some elf files (2023-11-21 09:23:27 -0600)

----------------------------------------------------------------
linux-user: Fix loaddr computation for some elf files

----------------------------------------------------------------
Richard Henderson (1):
      linux-user: Fix loaddr computation for some elf files

 linux-user/elfload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

