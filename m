Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4262B93AB84
	for <lists+qemu-devel@lfdr.de>; Wed, 24 Jul 2024 05:19:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWSWm-0007zn-4K; Tue, 23 Jul 2024 23:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWSWh-0007z3-Hn
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 23:18:51 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWSWf-0007gm-HA
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 23:18:51 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7163489149eso976245a12.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 20:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721791126; x=1722395926; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+q06mC/pXDtbKsoZjtWgJHTY2fPJp1SIdLdVjtB5AdA=;
 b=YPEOHsikBRGie2wdmVIdZ4Nr3Q9IcOd7qpzTllk5ktZvWKuqZePzWkJB4VZWmVxLkx
 mGFRuNaCFhHP2QfkJfVSHmNZszp9Ieu38WPoBSuFOGXnBrgmMRBxYIomiYgLr51R/DbH
 5pFZYQo0DH+nb1QtwSVfyIh6EtKKAvYU7g37ryYWDAJU4nKblZbiCDPaLOvpc5lU+Ei2
 5Mwyi8gs5n4ecMsxvctDRpjUJKYtATZtT3lJ8z5HXSzTJXVxOLg0EPjoppBKZhXaEOPo
 HUn5T1MXtYQ0VH0YtOwx2jMputgwsEGdPLV1qQ6nvcIjx7uKRvy1rm2k5eSlRq5LVGae
 TSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721791126; x=1722395926;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+q06mC/pXDtbKsoZjtWgJHTY2fPJp1SIdLdVjtB5AdA=;
 b=lRmx1H1Ryn2WyRywluskotuCsnGk9Gl50KJ/FNo4rkTk9X/Dts4UD4MZEzgTItJubc
 Rft4MfXUq/9WkC9dTv+RuV0hsrOk1DyPfv5xqfEd8coeqmzIP428TObilORbXwRHDnEo
 quFB1WZk+3dmTTEcLqP/rGilGghVIo5R6o4wMFw2tOlouLfsCKw/hj9sHV8igCkAOtHa
 +hmJa+qbfe3ALlezACWTsfLCywBwcLdHpLeodUst5+hfHVsTTOM+W/EDAKoWHLYXrax9
 fGe/YtRWjz4JIgLDPWj3jr28Qxdmgo8BmvD+xw+pO8qEo5GrjbsXugW57tZMK6Ll64wf
 evSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/yENfdvii0p6dcCrIpvVuOapmKnoylK8AzrzTVu1STGiDAYLyNEtIOfzlJRBnvY3oPtUia9ga4d55r+cQFf01P2YyVcs=
X-Gm-Message-State: AOJu0Ywav6L9EWN4aQZpuGh6LqMPy+fPWQpAQRd161lvYIWWL/+L9Fvz
 jAEe+rXp1Y3yhsB+bnRM9PO50KDYKIkn3YkFMaOqOG45fFoj0C4Ni+ncFaDhbzU=
X-Google-Smtp-Source: AGHT+IFJdXZrT73TIHX6Rf+r/FRLRhR0sAneLE15sQ2LIXXtTzd6EuzXbbHaGXgaSNTAAaN4LhR6TA==
X-Received: by 2002:a05:6a20:2587:b0:1c0:f5c1:8083 with SMTP id
 adf61e73a8af0-1c45e6fd3d0mr2337054637.41.1721791125488; 
 Tue, 23 Jul 2024 20:18:45 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70cff59dff4sm7651061b3a.152.2024.07.23.20.18.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 20:18:45 -0700 (PDT)
Message-ID: <a74fa25d-435b-4b9f-ad93-fbb268ad274e@linaro.org>
Date: Wed, 24 Jul 2024 13:18:39 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] Import vmcs12 definition from Linux/KVM
To: Don Porter <porter@cs.unc.edu>, qemu-devel@nongnu.org
Cc: dave@treblig.org, peter.maydell@linaro.org, nadav.amit@gmail.com,
 philmd@linaro.org, berrange@redhat.com
References: <20240723010545.3648706-1-porter@cs.unc.edu>
 <20240723010545.3648706-3-porter@cs.unc.edu>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240723010545.3648706-3-porter@cs.unc.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

On 7/23/24 11:05, Don Porter wrote:
> Signed-off-by: Don Porter <porter@cs.unc.edu>
> ---
>   target/i386/kvm/vmcs12.h | 213 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 213 insertions(+)
>   create mode 100644 target/i386/kvm/vmcs12.h

I don't think you actually need this.
I'll comment on that vs patch 3.


r~

