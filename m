Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF89740D12
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 11:37:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qERbk-0007L4-VA; Wed, 28 Jun 2023 05:37:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qERbi-0007Jk-Sh
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 05:37:02 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qERbh-0008RN-6O
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 05:37:02 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-313df030ccaso5264481f8f.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 02:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687945019; x=1690537019;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8WFU4gDYH74lGjgXBppWvAIXospQQPzTSJwB8DI68y4=;
 b=uv7yEHTignIvII5/+UvgPKPbSSob2dbvz0Nt5movzK8yYy7ga2rYihwqPWB4oN+wdb
 HBXi3XSXcEMO+Dhn17d/vGvPNmM69tKTQ6CsmnQzQZqETRKHUqZOq247OGK1aZBaGts3
 VGdir0/ux9cJFwciTq7G4mynAhIOsVRjN3QTt4bO3bdmeIUi5izZawNB11SbOALVyWnw
 gPw2pzCWFoUQhIz+kXYqYPzfqNeuTlKuucfXsXg7+X+tOJEvOaPt5BfrLTkJPSXFU+uZ
 KOxpK1ogYmK9K9X67aLO8oBL8Q3mF6QZYoyqPonPG/bqabDN1p8hwU3AEDYDlFFE9Zbv
 2wwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687945019; x=1690537019;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8WFU4gDYH74lGjgXBppWvAIXospQQPzTSJwB8DI68y4=;
 b=GgCLFCGP7OIT5yxd9ypKTX0PI+z3tXaa4HZbmkUzq1bS3Fl8x/hX177wBzGglCqcyD
 mlMEbsh2O1oXQCog28MFsJoKFbpkAyMGWO3QEEdCIjIyR5X0/nx4FcC6nXJMU31mNurg
 gWIzNC/uI9xA9wHz2KETy2S7Yq++Xs7/n+7nXkmJDUIybp0zuZVuLBnQ9OBulUN7MKk1
 +Xy375dpt0fS2WZDJ0uSkOZgQ1b1ofyGulwTnQBYSSCKbZc7w9WHMMQOCpxSC9fJDm11
 R/dmLPa4++AOLQN7D6cv2i0iLZOGRyLYaLak9xSv3WCCWmLLbOO1K57K6GG4tr39PT0g
 /QAQ==
X-Gm-Message-State: AC+VfDzv8n1vpJYQRp2tIX/i/8YXcq3uoiGihju8ldw9/1DLxjiPf4xD
 UnfGRSMgOWbNs2+fQ47Ia7Qr0Q==
X-Google-Smtp-Source: ACHHUZ51XbetUPPR05o7K9GOea8obSKPr8TOgoLVA43HwcaFyjyYMWoSulJpBP4bWLNOomT/9RaCcQ==
X-Received: by 2002:adf:ec84:0:b0:2ce:d84d:388f with SMTP id
 z4-20020adfec84000000b002ced84d388fmr27329085wrn.40.1687945019433; 
 Wed, 28 Jun 2023 02:36:59 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.103])
 by smtp.gmail.com with ESMTPSA id
 z3-20020a5d4c83000000b0030497b3224bsm12775712wrs.64.2023.06.28.02.36.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jun 2023 02:36:59 -0700 (PDT)
Message-ID: <698d29bd-20cc-20ee-3e7d-577d996894d8@linaro.org>
Date: Wed, 28 Jun 2023 11:36:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 4/4] target/ppc: Implement attn instruction on BookS
 64-bit processors
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20230627134644.260663-1-npiggin@gmail.com>
 <20230627134644.260663-5-npiggin@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230627134644.260663-5-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.103,
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

On 6/27/23 15:46, Nicholas Piggin wrote:
> +    if (env->spr[SPR_HID0] & hid0_attn) {
> +        powerpc_checkstop(env, "host executed attn");
> +        cpu_loop_exit_noexc(cs);

checkstop already does the cpu_loop_exit_noexc.



r~


