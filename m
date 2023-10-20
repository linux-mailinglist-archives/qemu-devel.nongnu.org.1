Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E247D0F9D
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 14:25:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtoYA-0004Mr-GZ; Fri, 20 Oct 2023 08:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qtoY4-0004Mb-ON
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 08:24:16 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qtoY3-0000oI-68
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 08:24:16 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4084e49a5e5so6323605e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 05:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697804653; x=1698409453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=MJjbJSejQ6MfyGvh+AjxoZWkdE3Onk5lvy5IN/zMVvI=;
 b=iUAh0Pz/WbUR4dtn6nxDFe39qAR1FsLFwPHkfW2T1o9IiRnN9gNPvx8sqjDQO8An9A
 MuOB23dVxmHhhupFEWy7KX+iKSahjGqaCoUSr4jURro2TlcwmPK9TAqxeHOFprI7UyFI
 QDFOeE8Ntc4nAQIvND3ACuJsQ/3OVcJajKuM3yOXiZbnAM4qSHai42KeidLqJsCDAgJF
 QNA9syUsmr0emJ6cf1oXQfT20Kb5WlwPTPWzzod3MjEiKtHjrU6YyfPddRrOAYTyNhRY
 U9fhAqEnVA0K3lPAzOmDKunoVIcXjdDwNf02lsvy/8JnLWTdbCuAg9WMGSjlTxmVFE/j
 GpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697804653; x=1698409453;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MJjbJSejQ6MfyGvh+AjxoZWkdE3Onk5lvy5IN/zMVvI=;
 b=vxmRMCDjakrPbZpNp5RjgTLWD6y9NykDcxMpyP6SIds1UzBENRtWBQDX14MhYYHgh/
 RIR99i9qSrTXPYVZneub75GHYWPbwIPpdEZxrAR7LMuvBCijgKmXUKvyCKH7jb3g6Rka
 eWfcTfn+ZZjFlo0ojL7XYHld2E9H0pvhZ4fI+Lp8fWowJMLPRNcDsdkw04SddRxQLAyd
 1Cc4kEJ6dggjUzzjrMJpdHB+N5+iPttUyVAX2ArqnxMatMTg45+MjKAYstIL+4SSiXo2
 xGQHNIXVLEG678P6iAgSEl8h0wYBYjrMc/yLYEWrvcGBquVFU7JsEz0pmlAfmtkv1Y9l
 GZKQ==
X-Gm-Message-State: AOJu0Ywy3sC64VAuD5pXIylirax6tzGW6ZIiCEWMOfWm/pXWRGCBVaIC
 KMraxuHZ9K2QfQNslDxDiahXxfLMDmjdxaZpWOk=
X-Google-Smtp-Source: AGHT+IFvzjFNDxIGSWO1Kxm4/msOsYtHzJcYGuelbRvcKfBwcQgb8Hg6Fk9A7Muf1gtrvY3hiqXeWQ==
X-Received: by 2002:a5d:474d:0:b0:32d:9cdd:a23 with SMTP id
 o13-20020a5d474d000000b0032d9cdd0a23mr1149278wrs.25.1697804653157; 
 Fri, 20 Oct 2023 05:24:13 -0700 (PDT)
Received: from meli.delivery (adsl-21.109.242.226.tellas.gr. [109.242.226.21])
 by smtp.gmail.com with ESMTPSA id
 k12-20020a5d518c000000b0031f82743e25sm1578140wrv.67.2023.10.20.05.24.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 05:24:12 -0700 (PDT)
Date: Fri, 20 Oct 2023 15:23:55 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: 
Subject: Re: [PATCH 02/17] kvm: require KVM_CAP_INTERNAL_ERROR_DATA
User-Agent: meli 0.8.2
References: <20231018163728.363879-1-pbonzini@redhat.com>
 <20231018163728.363879-3-pbonzini@redhat.com>
In-Reply-To: <20231018163728.363879-3-pbonzini@redhat.com>
Message-ID: <2tuga.hjrd4s8hfdvo@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32a.google.com
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

On Wed, 18 Oct 2023 19:37, Paolo Bonzini <pbonzini@redhat.com> wrote:
>This was introduced in KVM in Linux 2.6.33, we can require it unconditionally.
>
>Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

