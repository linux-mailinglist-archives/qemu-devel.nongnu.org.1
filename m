Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 633967CA361
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 11:05:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsJWy-0004hu-My; Mon, 16 Oct 2023 05:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qsJWq-0004h4-Bq
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:04:49 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qsJWo-0003st-9y
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:04:48 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4066692ad35so43813315e9.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 02:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697447084; x=1698051884; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=W1+YKtiA8QsWDjahaz2PBwfaH07fBmenVrnu/u64+mk=;
 b=oophl7f9TDYcF/q5PBlazEozeNIBsZCF6F/mCfGkFj1mVmg94T/ewHmY8Wa1mOjbdN
 /z55/CeGD2eZJCU/Q1uFShb3SFsxnaxq56sUmk32BL5F5FqMRQzGu2O7t+ut+PY8MLAS
 ANtquEunUMzCJwvMOdRlvfIR6gv3+WF8qdFxrWZlIfA4Tt5VqQEyuTbp7klCoM2Y6TGg
 4yZ1RmivjZ7ZzFj3iATzvNoQx6wYWqWLICkEE++0yFaD32Y+BB6jXyKi1k4jQyGDjFNM
 rm8Ch8kUHkymLvRB+qK1wxtZpZibAsGgmhbSfx8hGrZ7VXeR7L3/lNRFoPaESUIdwi1S
 G/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697447084; x=1698051884;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W1+YKtiA8QsWDjahaz2PBwfaH07fBmenVrnu/u64+mk=;
 b=Qa86vvTQ0eHAKRZhJIClocTx1ts9Z2bEm4P6V3khDtGGJ8pcHTkze/Sco8ys29jSHy
 a0cSoB2ifyx31ZTW29eslu0PRusDYcpfferSBDiSHfR+Rhf5xbyWvMvwqN3GRu2yLlHu
 NpJJAO7Lr11jEkl3nou2OssX3o2G8kYPIa6kTPipwwyOG3gPwp0Ehp3zrK2vqRVr3iiR
 TEzS0bzREmfH1Th5i9O1aCFzCXl6kbsWRj0IGuLls3gx/rfScryhWQGto18ZUc9F6V9W
 Xm7QDuqnxEPWzDjFPLxHNv3DkSBjh9yBAVWqCzyK13LMq6mQDuOWBJXXoc3E9k+CbvmR
 JCRQ==
X-Gm-Message-State: AOJu0Ywlj8eRMnJDeEYE9vha/v3WImQL6cVajvSkUtMAoCA9tcKYKoTz
 PVp2vX16umgqYlCBCrKsSb7/Gdepr8MGJ+CTeq0=
X-Google-Smtp-Source: AGHT+IHynkI0Byos9mh0mphguyaKPZqeZ8E7wi2mNjNP3qIuVC0dlQHSzPGI9Eyvcc8uGeYpZzOT+g==
X-Received: by 2002:a05:600c:2054:b0:402:906:1e87 with SMTP id
 p20-20020a05600c205400b0040209061e87mr28396206wmg.31.1697447084522; 
 Mon, 16 Oct 2023 02:04:44 -0700 (PDT)
Received: from meli.delivery (ppp-2-87-17-65.home.otenet.gr. [2.87.17.65])
 by smtp.gmail.com with ESMTPSA id
 e13-20020a05600c4e4d00b004065daba6casm6644085wmq.46.2023.10.16.02.04.43
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Oct 2023 02:04:43 -0700 (PDT)
Date: Mon, 16 Oct 2023 12:04:11 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: 
Subject: Re: [PATCH 01/17] meson: do not build shaders by default
User-Agent: meli 0.8.2
References: <20231016063127.161204-1-pbonzini@redhat.com>
 <20231016063127.161204-2-pbonzini@redhat.com>
In-Reply-To: <20231016063127.161204-2-pbonzini@redhat.com>
Message-ID: <2m6ju.ozl4ir9l8yw5@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 16 Oct 2023 09:31, Paolo Bonzini <pbonzini@redhat.com> wrote:
>They are not needed when building user-mode emulators.
>
>Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>

