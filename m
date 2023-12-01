Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1864D800828
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 11:26:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r90hr-0006td-44; Fri, 01 Dec 2023 05:25:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r90hg-0006mB-6t
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 05:25:01 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r90hb-0008Hp-UC
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 05:24:57 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a186e5d1056so248119766b.0
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 02:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701426294; x=1702031094; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Te4OkgsX35RkcPVDsJvTJwHDR2tUW0LsBAKejqLnb0I=;
 b=BIj3r1zdVVoChczlH6+ytE5zKXDOFVYhLfbN7YQvpqvLtJBf4pgpoBkPHdF7W+LXeG
 sc3Xku/4PUkseSM+7CNpO4zUjGpt9KMBfVkDFEuM4YiZcT2Szs2pggL+WavlrNqNpAXr
 TGsHI3TvtK+RTB83hFq8Bt6LriDgDmJxm6r3leZvqFqwU5QLeTVUUXvVAX6Kun1COZeC
 eIgukjqgZznHBoz21yjvgSEUfLPJ1NSmoF4LCejk27GggiYrSmyfOzfY6YhjcVIiBccZ
 zjsSgj+d5d8SQ6dOVe6QOGPVwl3P08DKIY+MTkBFFuHyLVmszYi8yJsulI7g6iomQC2J
 OM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701426294; x=1702031094;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Te4OkgsX35RkcPVDsJvTJwHDR2tUW0LsBAKejqLnb0I=;
 b=Am8zGmSrIqdjjFepk0vS+ERU20SkxVLubKPPs/s3094hxKG4/EsyQCmpsgQ67MdN2t
 I2z9CqiyKvJtanrg6JIgD/bBT/mmWQ7rpSxcWMjQTxVEcQXeHrT45Fnzdr7oNzVXmIKu
 vnb5WYIDMlMK3w0QE8Dmqi0TJXoQbrbfiK9g4DAxm0Gv/14oD3axk2QTHjzy8Rh2FNVQ
 N1/Rt1npdukWiy0xpkWCV50XMgFbKEMVOO78CxmZ4jYs4iLIAbwsRlOMK+hR82IXBcPw
 2wpCGhzOjCHdUYrs83LzF0lipqOp2VzRYVoF/c9J+73SbDVRi/hYXTgr+wt5lfVt9GKx
 u/6A==
X-Gm-Message-State: AOJu0YyxMXlEanIn0EW3XciUAYM1lda36xN8+w/XPIZfKaFJh3yXB9ET
 oF8FRSGPSxmwIfyLuqH/N7bF+Q==
X-Google-Smtp-Source: AGHT+IEgSQnaGf3bWwJk96UEsYp7n+eszhdgKJ/4nE6BfcQ3MyMrhMz8TsuOqStuCKScrU97HoiRUg==
X-Received: by 2002:a17:906:5a93:b0:a19:592a:f55f with SMTP id
 l19-20020a1709065a9300b00a19592af55fmr599223ejq.50.1701426293876; 
 Fri, 01 Dec 2023 02:24:53 -0800 (PST)
Received: from [192.168.69.100] ([176.176.160.225])
 by smtp.gmail.com with ESMTPSA id
 h9-20020a1709062dc900b00a19d555755esm632159eji.117.2023.12.01.02.24.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Dec 2023 02:24:53 -0800 (PST)
Message-ID: <2a9f829f-185e-4b48-86e9-d7e9d82d176e@linaro.org>
Date: Fri, 1 Dec 2023 11:24:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] gitlab: build the correct microblaze target
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Beraldo Leal <bleal@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Eric Auger <eric.auger@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Cleber Rosa <crosa@redhat.com>,
 Joel Stanley <joel@jms.id.au>
References: <20231201093633.2551497-1-alex.bennee@linaro.org>
 <20231201093633.2551497-7-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231201093633.2551497-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

On 1/12/23 10:36, Alex Bennée wrote:
> We inadvertently built the LE target for BE tests.
> 
> Fixes: 78ebc00b06 (gitlab: shuffle some targets and reduce avocado noise)
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   .gitlab-ci.d/buildtest.yml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Oops.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


