Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B840471232F
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 11:16:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2TXX-0007NA-4T; Fri, 26 May 2023 05:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q2TXP-0007Mb-0r
 for qemu-devel@nongnu.org; Fri, 26 May 2023 05:15:08 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q2TXN-00027q-DO
 for qemu-devel@nongnu.org; Fri, 26 May 2023 05:15:06 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f60b3f32b4so3456025e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 02:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685092504; x=1687684504;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HcxotIymuKgPv9JlBeexmHsVC4dTpSlBSdw2E1CAOBc=;
 b=Ht/Ejd3zZQJ2bRW0ksKq14JmgEr0eYjrjdHzXD+Hzh8XIeF6zC40Na/W6ZeoKrhJ31
 yrWDgTr4Sjjz6FYhTyW8Ba16j7FcvbHQ2jOiaSuC+W22YpwGHsqKGT4JU01r2SzMhOLa
 4IlmipBhGXh1ydOUpYyOObdma69zfpdyN1720D6TQ2JEE+LJhab+BalLg4ANELPLg2he
 uhuNosLq9z6ECsXd3GZneR6UdrlXt2Uyp25QEbqQLrgUwe7NT6SG+ickbVbVlifiXnud
 MRwh7YSPNXGPYcrlhjhWmmzidRA9c/qY2deDHFMMDHP2Q/YftSWRf1tKQycExCP5/mJo
 lIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685092504; x=1687684504;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HcxotIymuKgPv9JlBeexmHsVC4dTpSlBSdw2E1CAOBc=;
 b=kdiX2FaanTn+QcouNMIF7pnCsy7VRNWgNlUo8ifvasBDpbPwkAnaaCU2CvDaznUcwQ
 cK24MtdNY38T3+UhcgD8KszwS2ALoISjB3iZQWb91zgMLTItkirKy82Nl15R/zAckXKu
 v24lmp0zEqLTf8DOrJozgq/Mv31KEVT3rdQNNndHGf3RUeuWCdMAHmlS1lOm9lIC/PFu
 qZAylUuY6WkuWRFz9OuzNNWE4HMq62tJ4Hxb7lFpfKNf/ckoYrE4wFLgkTSo+tCrsDsQ
 ost4PmT/zUP15Q48ETpsWEGfTs2wd29WlUy8BSbVNm08YwX3IpL+bkmyNCupJ0pXOzlL
 mINg==
X-Gm-Message-State: AC+VfDzpspqSpsrzrNjIk9wyYVch7thwJOJ9ER9EDIL3O0tL/TQpo23y
 4yUIGisXW4EvSt6CTCv61sFRI5SyfutFnxMWux0=
X-Google-Smtp-Source: ACHHUZ6zlSjF4sLJbzVKde8KZenwp9jn14oA43MoNL2aRVEYkTfQLd16QprZa5uymenHL3JPSUVWXA==
X-Received: by 2002:a05:600c:b55:b0:3f6:174:8c32 with SMTP id
 k21-20020a05600c0b5500b003f601748c32mr1042679wmr.6.1685092503737; 
 Fri, 26 May 2023 02:15:03 -0700 (PDT)
Received: from [192.168.69.115] (vit94-h02-176-184-29-207.dsl.sta.abo.bbox.fr.
 [176.184.29.207]) by smtp.gmail.com with ESMTPSA id
 o10-20020a1c750a000000b003f4248dcfcbsm8229663wmc.30.2023.05.26.02.15.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 May 2023 02:15:03 -0700 (PDT)
Message-ID: <d5a005f4-f612-3a45-873a-0381dbfdc962@linaro.org>
Date: Fri, 26 May 2023 11:15:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 14/27] tests/vm: add py310-expat to NetBSD
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, berrange@redhat.com
References: <20230516105908.527838-1-pbonzini@redhat.com>
 <20230516105908.527838-14-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230516105908.527838-14-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 16/5/23 12:58, Paolo Bonzini wrote:
> From: John Snow <jsnow@redhat.com>
> 
> NetBSD cannot successfully run "ensurepip" without access to the pyexpat
> module, which NetBSD debundles. Like the Debian patch, it would be
> strictly faster long term to install pip/setuptools, and I recommend
> developers at their workstations take that approach instead.
> 
> For the purposes of a throwaway VM, there's not really a speed
> difference for who is responsible for installing pip; us (needs
> py310-pip) or Python (needs py310-expat).
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Message-Id: <20230511035435.734312-14-jsnow@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   tests/vm/netbsd | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



