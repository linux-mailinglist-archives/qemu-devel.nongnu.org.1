Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 501A17BD355
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 08:26:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpjie-0004mt-Qu; Mon, 09 Oct 2023 02:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpjic-0004m7-Fw
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 02:26:18 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpjib-0003BZ-0n
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 02:26:18 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-53447d0241eso7388253a12.3
 for <qemu-devel@nongnu.org>; Sun, 08 Oct 2023 23:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696832775; x=1697437575; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=20Ifft4iQXIStDV+dubsiI3yTtyizAGRaVQNp0ZDLio=;
 b=WaPXHypDTt4VH6twbF7Da57a6RR8HUA8qEH6FQPieszPqdXjL9VJ6Qo+P7kYzUFKbW
 oBnx2iEM3AwjT0oLSa/D/j8NJeO7LyMx+FjCRcoY7BsRv6c5LpgeH5L5Usp3ojxsWGHV
 Yc3ZkslSJVSMmw8OHvQIO58mg9pPJ/GKExE2gIOi2BmJGwsLjCkPu0oZ9TRaMRHgFeqf
 /9VBiVJp8FMa0ClzHKBkB41uPRwGYt5+MLroOZvD1sm1CZkmyy1CsPg08rlYPrlMUZkW
 +AC5GsZFqA+oh6f5EEVEQPL4qM/5YcrKT+1Cq5umnsDRs/WlIVBg1UC/nkBij7ASf1C5
 qfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696832775; x=1697437575;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=20Ifft4iQXIStDV+dubsiI3yTtyizAGRaVQNp0ZDLio=;
 b=TkadA5MnIv/jgn9ANzXvRS7LrqYKAIEmtuJgBA3SkbqkBWXyUaS1+pqRdIqPELcFnH
 +4zQS798vsRoSzFpw8lrCHYr02mO56hdWJBdKdpO370nhOr1p/BWcE8S1PnJE3safw3r
 fAildpOTcmBh0ih7h0P2kRB48tj0+crbFdV4GemqESdrpvWqZJSxZyaIDsaJXRkY2eVX
 bEVgbR//+WKIZjjfKsaZvrlZoLrSevKb6zzdFwh5HGDhCV14R6yMbo1l4kSg4HVEQqBE
 XcRv294HCfYf7xdPFLXAs8MmFOklcHWyTThFnvAAtCvtNfna/Jy/F77iSrhEtB04dfKg
 tytA==
X-Gm-Message-State: AOJu0Yw4aCUZ4o2Pss+vLQwwEPX32ka6xlkJxL54b8opeMi1j+Z2dZZs
 WtmyJ+YnECMrGLpiw97g1BOVfw==
X-Google-Smtp-Source: AGHT+IGRJNtjS8uMB4HWzbgH8ehMhToYfqaf/aQ6E/OxT1fjqmdHyKDFr7i4PZxus3LFVUrD7pGMYA==
X-Received: by 2002:aa7:d8d3:0:b0:52b:d169:b373 with SMTP id
 k19-20020aa7d8d3000000b0052bd169b373mr11506728eds.32.1696832775406; 
 Sun, 08 Oct 2023 23:26:15 -0700 (PDT)
Received: from [192.168.69.115]
 (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr. [176.170.217.185])
 by smtp.gmail.com with ESMTPSA id
 o26-20020a056402039a00b00538538f1fcesm5715490edv.47.2023.10.08.23.26.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Oct 2023 23:26:15 -0700 (PDT)
Message-ID: <80ac69c5-0eb0-d2b2-555f-e1f2a8d8ac7b@linaro.org>
Date: Mon, 9 Oct 2023 08:26:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 2/3] vfio/ap: Remove pointless apdev variable
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com, pasic@linux.ibm.com, jjherne@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, borntraeger@linux.ibm.com,
 aik@ozlabs.ru, eric.auger@redhat.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, qemu-s390x@nongnu.org
References: <20231009022048.35475-1-zhenzhong.duan@intel.com>
 <20231009022048.35475-3-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231009022048.35475-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.818,
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

On 9/10/23 04:20, Zhenzhong Duan wrote:
> No need to double-cast, call VFIO_AP_DEVICE() on DeviceState.
> 
> No functional changes.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/vfio/ap.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


