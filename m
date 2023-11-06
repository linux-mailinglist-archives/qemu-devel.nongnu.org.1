Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7F97E1AA0
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:01:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztZH-0004QL-Jc; Mon, 06 Nov 2023 01:58:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZD-0004Ov-K7
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:35 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZC-0001Ml-3J
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:35 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1cc4f777ab9so27983425ad.0
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 22:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699253912; x=1699858712; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oboVQOi6EvjisHoCt0AjEUt8Log6Mds8YaieNrV812g=;
 b=rKDQIhEoF2z0pMpaw3Jnw22vuXWOpajg+jzVAOiv0hCUPrE5O/OGTqXwCPktR1PDQ0
 2MHhDUl9CaXKWPCVtE6Zgukd/mbNjzWSN2srC606jpf0x2G6WW8ybsXXHMEgew4VQjLU
 eXw9sEMb1wpVzZ1Htu8QZyffjy+h2TWefCbWvw99rGNNhBYyd3MYco8F1gVfM/WiWlMt
 KcnuLJ8bPY/nH5ZIH7+aA2Xb0I74UmnKe+V2Yvv0WdB/z1FxLgo2mzgs6lTx6HzS17h/
 +RtSsEBAHPvzDq6KOl41qYTYqwnnr7+o2Z3dl6VAk4pJn0cQqCBcAR18ICcQpfF8GmkA
 nDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699253912; x=1699858712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oboVQOi6EvjisHoCt0AjEUt8Log6Mds8YaieNrV812g=;
 b=uIfwvkUqLUqLS1+awdASsdI0K7lZmK4W2y/rvZrnanDfTrjWiKgmBZRk8TT21h8oH8
 GGjgVmeUTCNehtHSDdRAKBo1bcELDYijgk5UI4nU7OXkQwCVzmhCetRqVWPEcsisPm9z
 yCU299WwvW4PI3iQxSS57u5bF4YuSiKLdSOyTrJ/dQWQaUw6VzE5LkuCq7l3bvuPk+cp
 ZvNA8O+gTFXt7VIEeO61iWxXgoLWkh07lsd+IsQuG5PMq7mcyekmmkJnN9mLS12Z6Udn
 nTAuNmOe4SLgD920qKCifaBjUWMapaaTev2xPuXaJPzVksTldEULVfyJ9mXgXs2V4s9O
 Izdg==
X-Gm-Message-State: AOJu0YzkrfpLhQumC+8qIp7ZBujCHobnTQC8C/7EfNNl52P8lIX9Z7NG
 sMWfIlvbcLWm2a60Til1e76QchHl4D8axHRdmzw=
X-Google-Smtp-Source: AGHT+IFt/bCvKnMTwyTOADnkCuqgtXdwRvKej70oSJiM+omHdeVKkPIsB09+1NGbg6+kav2Y8UBbJA==
X-Received: by 2002:a17:903:1250:b0:1cc:7ec0:bc8a with SMTP id
 u16-20020a170903125000b001cc7ec0bc8amr12698683plh.66.1699253912472; 
 Sun, 05 Nov 2023 22:58:32 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c3-20020a170902d48300b001c62e3e1286sm5167130plg.166.2023.11.05.22.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 22:58:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 04/71] target/alpha: Constify VMState in machine.c
Date: Sun,  5 Nov 2023 22:57:20 -0800
Message-Id: <20231106065827.543129-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/machine.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/alpha/machine.c b/target/alpha/machine.c
index 2b7c8148ff..f09834f635 100644
--- a/target/alpha/machine.c
+++ b/target/alpha/machine.c
@@ -24,7 +24,7 @@ static const VMStateInfo vmstate_fpcr = {
     .put = put_fpcr,
 };
 
-static VMStateField vmstate_env_fields[] = {
+static const VMStateField vmstate_env_fields[] = {
     VMSTATE_UINTTL_ARRAY(ir, CPUAlphaState, 31),
     VMSTATE_UINTTL_ARRAY(fir, CPUAlphaState, 31),
     /* Save the architecture value of the fpcr, not the internally
@@ -73,7 +73,7 @@ static const VMStateDescription vmstate_env = {
     .fields = vmstate_env_fields,
 };
 
-static VMStateField vmstate_cpu_fields[] = {
+static const VMStateField vmstate_cpu_fields[] = {
     VMSTATE_CPU(),
     VMSTATE_STRUCT(env, AlphaCPU, 1, vmstate_env, CPUAlphaState),
     VMSTATE_END_OF_LIST()
-- 
2.34.1


