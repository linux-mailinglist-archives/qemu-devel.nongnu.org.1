Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C0E7F3EA6
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 08:11:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5hNB-0004KB-SQ; Wed, 22 Nov 2023 02:10:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r5hN7-0004J5-Kr
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 02:10:06 -0500
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r5hN5-0006MQ-Oo
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 02:10:05 -0500
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2c50fbc218bso79312361fa.3
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 23:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700637001; x=1701241801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=iI2AN7bLsD/0pRvuIOpWL6/ny3ZU7AtowJj8Ak7rJow=;
 b=gX2kBjtCVxAEaLeApfd3XHEMurBKABSxc31nsRKX8OY3+SV1QA24xu2MT08kqoekJ+
 PQel7CJzv6M6QN/cklF1ZF6FAPxARxvjRJnXukvqP3NORujNGdFiC/WrKIiNcIeR5rru
 uTBNtpFfjoikbG5w8gZj1s3N4oFG09S2QRJKhmiMjy35ibuvheIEQHAJar4WWhqppPbk
 foHjdoeBqTYevnE/cMvDrlxg8ILwbktePjtxe3y33pgsDPk4b3/braFaiLyvIrC3Nw58
 5xz8YdWVyefN1UrSDBtV6j1uEb7QsNiJQVoClpL0zPAbPaZYlH31G1Wx2jg9Rdae7RKh
 r5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700637001; x=1701241801;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iI2AN7bLsD/0pRvuIOpWL6/ny3ZU7AtowJj8Ak7rJow=;
 b=GcbDCBlEPJX+m9hC7RaaethaI1DCwWSH66iwW+XWkaQKiCMjJUwiTUfNmUanFB9AHO
 Mv11LlFhgUJk/owC3aVsZza+P9e/BGY6fjHjO9OQzyVg3K9P8OifYV2HJWKWRfvCCmcP
 JZaoQlyXQ46X07pD6d7+ZU+XTChdJHg/UgodlcokNu7lEGZn2ZJdB/60N77yVxcVxYGC
 CDoWSul6YbraiGq7l6VezLE2y/1toXupuYsjp7AuucWmbUOsKx8wzLUq2eirPTy+KY/r
 9epjrwKu6HQi07v/ypFqxvoG2jiOE6ZhrTak18MiJDeRIPXsvRlFuslKMKq2TEWV2PSj
 ysKw==
X-Gm-Message-State: AOJu0Yxr8wTnRKJpQs6rcIsqz4nCqntbZxgl/kCNAqSxPMB/v+Ju3JPT
 ajXhhb0e1ZOt7EfJjB0wlAdXt3vroViwHm2rzuVhow==
X-Google-Smtp-Source: AGHT+IG8LUgkySKJxf7UtbCaIc6KjzraWf7jQav48/WI5t4d3EAV523IatjNEpeICcEvMu4VJDDmaA==
X-Received: by 2002:a2e:9250:0:b0:2c8:6f42:e2f8 with SMTP id
 v16-20020a2e9250000000b002c86f42e2f8mr975176ljg.16.1700637001284; 
 Tue, 21 Nov 2023 23:10:01 -0800 (PST)
Received: from meli.delivery (adsl-27.37.6.163.tellas.gr. [37.6.163.27])
 by smtp.gmail.com with ESMTPSA id
 g15-20020a05600c4ecf00b003fefaf299b6sm1155752wmq.38.2023.11.21.23.10.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 23:10:00 -0800 (PST)
Date: Wed, 22 Nov 2023 09:09:36 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>
Cc: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 C=?UTF-8?B?w6k=?= dric Le Goater <clg@kaod.org>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH-for-9.0 14/25] backends: Use g_autofree in
 HostMemoryBackendClass::alloc() handlers
User-Agent: meli 0.8.2
References: <20231120213301.24349-1-philmd@linaro.org>
 <20231120213301.24349-15-philmd@linaro.org>
In-Reply-To: <20231120213301.24349-15-philmd@linaro.org>
Message-ID: <4ijwm.ioplbxwzwzjo@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x22f.google.com
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

On Mon, 20 Nov 2023 23:32, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>In preparation of having HostMemoryBackendClass::alloc() handlers
>return a boolean, have them use g_autofree.
>
>Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>---


Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>


