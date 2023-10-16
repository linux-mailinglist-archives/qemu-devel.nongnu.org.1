Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A827CA474
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 11:45:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsK9h-0006SF-MB; Mon, 16 Oct 2023 05:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsK9c-0006O7-IY
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:44:52 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsK9a-0003Cv-NR
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:44:52 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9b2cee55056so749694066b.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 02:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697449488; x=1698054288; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q6S2J0/OfQ9p9QV/tzIWrKCsuDsPgQkjMi3/xa90208=;
 b=ouJEl02M8p4mQs+eZWGIqO4sT+fM3yAZbLlM57b9BzExbblqf18SHO5wRhEx9m2L2j
 Wrda90zdU12tqml9bzg/J8SR7hW+hg5R+pf0l2naS7vH+W9+DsSCfkpp+vfLY+Ps4731
 A7RvH2WGdgc6T7yXnWngmQZ9B/x7n7OkHTsAXFmQxGS9ASnGPPKTMBnWhtlSO+fzkS2H
 DaEXvHpJ8ixYeD8C5SoymsRqGmsBvnOb2o66ovrPkO3fdYV9AxgMdXbaHk2cNrmrnk2b
 +grKR3+DxtZNR80/H7yoTHl3Qby9Rjz0k+9GlJX7VPM0thTTUxdjQl8ZAMtuvFrvUul2
 ZISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697449488; x=1698054288;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q6S2J0/OfQ9p9QV/tzIWrKCsuDsPgQkjMi3/xa90208=;
 b=ii8uW5Nmmp6oBYdV7o3b/sXHrpAz3ENFjh41pfjdUIw8pKP4DBSh35EYaXZYL3IdY+
 7kQ7SpkGg3swnNYNDiqOBWa13nsxpJRxRfWLTudr8s3FKsCrhLGeTFkniFOqu2LR0hfT
 G4BaaVAtDU4Q/gtj2qX9Nos+HDE/bbDWAaQCgzouGT47NvdvWGwlfiEqc6PeD+SXDXaw
 P/8U8y2j88r0oNTJVmBMyUjLINFGrJNN+fNFF3u8PQMXSTKvK/85v1Bh3Vzkdx8Ssm2F
 8ZHlOAYOsPkbtZXKNJQYyFpQxzjvH/KNRL1u6rYFf92etIjNsLz0KhSVDpOOSnEno9tm
 vBTQ==
X-Gm-Message-State: AOJu0YxdTcg4jMQz7F+7bVxx5+gYm4a7LgDB1O25SRVc86D1hg9auLZy
 jaH20Pb+DoAj9ZUqLibpuwdY6C4A/GVVmXHomMo=
X-Google-Smtp-Source: AGHT+IHcJPaE2MKgUFA9f2WK9pCxLurHRbJCkO0ucoc6pIWwiT/Ger+ImueFb7j2ixvd4+E5mlq0jQ==
X-Received: by 2002:a17:907:7fa5:b0:9be:6ff7:128a with SMTP id
 qk37-20020a1709077fa500b009be6ff7128amr5456761ejc.67.1697449488683; 
 Mon, 16 Oct 2023 02:44:48 -0700 (PDT)
Received: from [192.168.69.115]
 (9r679-h01-176-171-216-136.dsl.sta.abo.bbox.fr. [176.171.216.136])
 by smtp.gmail.com with ESMTPSA id
 l11-20020a170906230b00b009adc7733f98sm3726197eja.97.2023.10.16.02.44.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 02:44:48 -0700 (PDT)
Message-ID: <60b9129b-9c7c-a4b5-6ff6-8de11388d376@linaro.org>
Date: Mon, 16 Oct 2023 11:44:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 0/3] hw/pci-host/sh_pcic: Style cleanup
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, qemu-trivial@nongnu.org
References: <20231012041237.22281-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231012041237.22281-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/10/23 06:12, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (3):
>    hw/pci-host/sh_pcic: Declare CPU QOM types using DEFINE_TYPES() macro
>    hw/pci-host/sh_pcic: Correct PCI host / devfn#0 function names
>    hw/pci-host/sh_pcic: Replace magic value by proper definition

Series queued, thanks.


