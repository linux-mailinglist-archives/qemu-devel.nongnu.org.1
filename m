Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE44C7091BF
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 10:36:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzvaI-00010H-C0; Fri, 19 May 2023 04:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzvaG-000102-1Y
 for qemu-devel@nongnu.org; Fri, 19 May 2023 04:35:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzvaE-0004y5-HS
 for qemu-devel@nongnu.org; Fri, 19 May 2023 04:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684485329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cpUUmVRA2tb4K9vWob5lHlCs7a3j7p2lrVdRexEB9bc=;
 b=hLhwQip/nk8ApwcW+R1ffzKmgav3m1YsCtp5yHGerXWAP1Bq7sTr+NMK3iXeKX5F+GZaQN
 daVQw6bfVxdxUKSdC0sHLbhl/Keocgrjldllre+JsAMV29AxHLrm5v3hfYXInfFbMtV+MH
 w/L9mJBaeWryrfPAIV69nc/cUteA//4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-MT4vjsLfPPeo9w63bPdlHQ-1; Fri, 19 May 2023 04:35:28 -0400
X-MC-Unique: MT4vjsLfPPeo9w63bPdlHQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-94a356c74e0so330107566b.2
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 01:35:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684485327; x=1687077327;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cpUUmVRA2tb4K9vWob5lHlCs7a3j7p2lrVdRexEB9bc=;
 b=a0jdo/OL7gJeB19VWPXGGx8MlejVQw7n4+q9rVzEjp4A/q/sF+l3ilPs+YTwESPtyk
 FhagCvne+77WK7llAoGeQgY+y6U0bh/V42dDLLJ1m73AFYi7ARcSEHccW0Qh65omzZMV
 Rqr62bUfJAkvJJ4PafAHWpVJWUhvsS3VUKZTBInPXgMJZzlo+IPk73Av9Ej9f4VgWoC7
 VyOacr2yWG40dJevaQEJ7G+lqe5ucA5C0qp3jBv6VKhUq58BEZ7vuYGtgzJ17u3PC9hE
 9jl/acNDZX/F+rmK/4PnveoYe1gvKkfVZH3fIcYvYYEG7aG8HOoljQ1H0kmdS+TgTpJd
 cILQ==
X-Gm-Message-State: AC+VfDx2T558KEeVdhIvUJhYLGqbRdr8/7yI3aYNXXod5pWgTC6hsQMz
 M3KFx9EA9+nThyRIZwdx4MZFK0w+L647b8Tl3CsNRc2DwxL3tY9htgt/Aq4XHuu6cP9t/KMx32S
 AbXJ6W7QvtgVZCU4=
X-Received: by 2002:a17:907:dac:b0:962:582d:89d7 with SMTP id
 go44-20020a1709070dac00b00962582d89d7mr869308ejc.38.1684485326862; 
 Fri, 19 May 2023 01:35:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7MqCcmKHPUMdGPfywWu7aUm84I5jT2OagdVRya73ypgyxCsYgKNXFBHzrSYlwLRcklATJSsA==
X-Received: by 2002:a17:907:dac:b0:962:582d:89d7 with SMTP id
 go44-20020a1709070dac00b00962582d89d7mr869292ejc.38.1684485326539; 
 Fri, 19 May 2023 01:35:26 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045?
 ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.googlemail.com with ESMTPSA id
 k1-20020a170906970100b00965e1be3002sm1981218ejx.166.2023.05.19.01.35.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 May 2023 01:35:26 -0700 (PDT)
Message-ID: <c30613c6-0521-2b0b-57cd-7c860096cd05@redhat.com>
Date: Fri, 19 May 2023 10:35:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: gitlab shared runner time expired
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, Camilla Conte <cconte@redhat.com>
References: <58b8067d-3136-94ed-f53e-2ccd0feb8c75@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <58b8067d-3136-94ed-f53e-2ccd0feb8c75@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.544, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 5/18/23 21:26, Richard Henderson wrote:
> So, here we are again, out of runner time with 13 days left in the month.
> 
> Did we come to any resolution since last time?  Holding development for 
> that long just isn't right, so I'll continue processing the hard way -- 
> testing on private runners and local build machines.

Hi,

Camilla Conte has set up a Kubernetes-based runner on Azure.  If you
apply the two patches here:

    https://lore.kernel.org/qemu-devel/20230407145252.32955-1-cconte@redhat.com/

You should be able to run pipelines almost as usual, just with

    git push -o ci.variable=RUNNER_TAG=k8s ...

Camilla, please confirm that this is correct.

Paolo


