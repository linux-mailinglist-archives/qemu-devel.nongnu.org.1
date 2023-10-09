Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5BA7BD357
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 08:27:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpjj4-0004xd-Ia; Mon, 09 Oct 2023 02:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpjiy-0004tH-VE
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 02:26:41 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpjiw-0003Gq-Em
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 02:26:40 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-533c5d10dc7so7176085a12.3
 for <qemu-devel@nongnu.org>; Sun, 08 Oct 2023 23:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696832794; x=1697437594; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ktvGzo2VUXA6iPNupBlEdYjlATOWvtuZ6rc/3cUubco=;
 b=xi/ODa27GGH1rlEE1TAjeh3viQyKtTN87N+wD1hmb/EWAoHa5rY5jDkiarj7ryZccO
 CwfpLTPFude6FNBPxKN+RkyQG5P5E3uixHt35eM297H7Sp63txN9JiydmfOsV3rZBdE6
 BKXwPDH+UKFni2K5tRSBop1B6MEw/nqvgMaC1o3vXnfpfO2j+WaUvLeu8TOW9av7h5ta
 AJQdudGhtYXU1JGysGmz7LPK+SaI4POyvCac4M6aQwwwsfA+yHhYWIhQxJVQ9PgCFwdM
 nm8yutUn/TlIKXlFqF8VX9f6geD3kWA34ACxf4zKFQ+t3YTB77q0SEjHddNTJmIh6F2R
 8WAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696832794; x=1697437594;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ktvGzo2VUXA6iPNupBlEdYjlATOWvtuZ6rc/3cUubco=;
 b=K9LZUyWVaH29kzk8bMgPJAkrBOJXcrAywQZuvJwDb//3NWsiqviVIDfz37EHb1Nnt2
 3SpnKKzzi/9ZKyIfTLJAbS3mBW4FkKKLIeGfDaCvSwGmI+A1hLLP6kEAFoJz3+4zTNp9
 qMgKjbaAF1ZNdG/evLKeFAvER2NRqXJVLOL6Glj+75HlmU6VTSVGbVyZvvLS6AvMgpUC
 PIYWUcpcUf4lQIHKy7gsw6LSJU3fRhm35VpKNvu6G1douuELgGYpB6GvVCwGnCaQdrr9
 i79LGQvfftmfTmz0eVLPZm/s4KoqCdcd0X+K0ZFIckWD2LLUzofGx8GhHv9/n3axLw2w
 fzfQ==
X-Gm-Message-State: AOJu0YwquPC6L5GiQlOnjUvzH+Uh08FiE7bv9XrjXSHLZ7WliPjy23rw
 w2kNJtt42NcapTr6VdWwWPVpZg==
X-Google-Smtp-Source: AGHT+IFqmnYrUEJFbuTFE9+CcMUkJyL70/bkGBttS3KaK4k0y8DtP8ml/lGY7/NqC65JiFFlvuwxnw==
X-Received: by 2002:aa7:c302:0:b0:533:97c:8414 with SMTP id
 l2-20020aa7c302000000b00533097c8414mr13907182edq.7.1696832794502; 
 Sun, 08 Oct 2023 23:26:34 -0700 (PDT)
Received: from [192.168.69.115]
 (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr. [176.170.217.185])
 by smtp.gmail.com with ESMTPSA id
 v6-20020a056402184600b005333922efb0sm5734521edy.78.2023.10.08.23.26.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Oct 2023 23:26:34 -0700 (PDT)
Message-ID: <732b8e51-e06b-67e4-479e-ef34d66fe56d@linaro.org>
Date: Mon, 9 Oct 2023 08:26:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 3/3] vfio/ccw: Remove redundant definition of TYPE_VFIO_CCW
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com, pasic@linux.ibm.com, jjherne@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, borntraeger@linux.ibm.com,
 aik@ozlabs.ru, eric.auger@redhat.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, qemu-s390x@nongnu.org
References: <20231009022048.35475-1-zhenzhong.duan@intel.com>
 <20231009022048.35475-4-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231009022048.35475-4-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.818,
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

On 9/10/23 04:20, Zhenzhong Duan wrote:
> No functional changes.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/hw/s390x/vfio-ccw.h | 2 --
>   1 file changed, 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


