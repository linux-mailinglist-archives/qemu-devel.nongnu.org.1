Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 602747EA2AD
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 19:17:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2bUP-0005K4-Ln; Mon, 13 Nov 2023 13:16:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2bUF-0005DR-Ue
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:16:40 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2bU8-0000KT-Qj
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:16:38 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1cc30bf9e22so36138845ad.1
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 10:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699899391; x=1700504191; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xGaoCvEhVKgnKhzAuH2lcBIsGnVExx6jtGAjreAN1U0=;
 b=XlW2qbfNGvHXbojeqkOkqguvP532ujozkH6xJJOSjpTp2ZZLLB+hPFOFw4UuARTdqI
 j2+leczxYGFH3Oq5EM+Wkt2g27Yy/j8tStA+WAusIAUQglwWJreGBVrX4Jxya6IsilOn
 7POHr2l/3nxm+5uMGEnQD2m6dvTrnrLEchd/rZczQSbENTm1s/j5AEG/WkkHBo/JPLfT
 DAFJ8YMG6DZJwrqsVhMPs9qyjQqH6CSofVOyKOabc8T0kKHGSryOuCIOpFe2zPAwKvIs
 is0lKjbvDfPn6q3E0je5L09n1kMhvwGFO9dIMtI+8JGWA3JDr7IeqA43EQ/pN+CuMPpk
 pN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699899391; x=1700504191;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xGaoCvEhVKgnKhzAuH2lcBIsGnVExx6jtGAjreAN1U0=;
 b=jt12aIdVTJLVDuzCfhSZuUacPgSmNWtPIzA4oLfQkf0psRxxK3Ul8yK70ZRvV6KVvh
 tq0yP+8LHDMWIZgYIxpJyRn6fiQ0kPGPcFS0xprM6wzvEtCsfOggx18Tzn57T/aGAmiI
 IoShMRQtbvJ04/jSUOITTmZxKZ1QmOiNdr2IVVWqOrz6bpjzIWUMfVWmQQVXMLcNI18R
 rrB8l+D9diFcXPM9PUYLJKc5hn/u0x5nRZ0q12sMJg31DizVVTlZdD085tqDN8KQF6du
 BmnAc9UCU+cZKEi0nrG+NVRbXb9aGV5sVRpNDy3fNCqhYrsiVQ99FmLFnGVM5OlbmKaV
 L1eA==
X-Gm-Message-State: AOJu0YyokSJYixuhf6h0GWdi8eaK12+NHTUsnvQ4raL15s8RlcTRPuFz
 4EpvSBfgdqZxkT6eITUItheDGg==
X-Google-Smtp-Source: AGHT+IFGtFwOCO00qTve4imDefB/v7Y14ItQYfH6PPqxvc6xD2b0XUfTEVU90N6JSOVtl3xeUhxBSg==
X-Received: by 2002:a17:902:b693:b0:1c0:afda:7707 with SMTP id
 c19-20020a170902b69300b001c0afda7707mr310903pls.34.1699899391077; 
 Mon, 13 Nov 2023 10:16:31 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 ju10-20020a170903428a00b001c59f23a3fesm4142792plb.251.2023.11.13.10.16.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Nov 2023 10:16:30 -0800 (PST)
Message-ID: <a50b0790-03d7-458c-834b-907e130bb5fd@linaro.org>
Date: Mon, 13 Nov 2023 10:16:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 04/10] hw/xen: Factor xen_arch_align_ioreq_data()
 out of handle_ioreq()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Woodhouse <dwmw@amazon.co.uk>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Paul Durrant <paul@xen.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20231113152114.47916-1-philmd@linaro.org>
 <20231113152114.47916-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231113152114.47916-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 11/13/23 07:21, Philippe Mathieu-Daudé wrote:
> diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
> index c028c1b541..03f9417e7e 100644
> --- a/hw/xen/xen-hvm-common.c
> +++ b/hw/xen/xen-hvm-common.c
> @@ -426,10 +426,7 @@ static void handle_ioreq(XenIOState *state, ioreq_t *req)
>       trace_handle_ioreq(req, req->type, req->dir, req->df, req->data_is_ptr,
>                          req->addr, req->data, req->count, req->size);
>   
> -    if (!req->data_is_ptr && (req->dir == IOREQ_WRITE) &&
> -            (req->size < sizeof (target_ulong))) {
> -        req->data &= ((target_ulong) 1 << (8 * req->size)) - 1;
> -    }


I suspect this should never have been using target_ulong at all: req->data is uint64_t.


r~

