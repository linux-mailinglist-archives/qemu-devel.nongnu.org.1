Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3857096C5
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 13:50:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzybE-00014Z-6g; Fri, 19 May 2023 07:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzybB-000147-Tn
 for qemu-devel@nongnu.org; Fri, 19 May 2023 07:48:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzybA-0002G3-Cb
 for qemu-devel@nongnu.org; Fri, 19 May 2023 07:48:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684496919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tyAqPOA30jlygdwot+rINyW6Md0cSwyA2f+ayCCD3uk=;
 b=HUBZezbh/y86FiIXPaBMf7pZc8I3k3jfX3bxbhjF8bawMzb+duJegtFeRLlkwKxv8PMycL
 HFcaxjGPK3nyYEP5rxqxxCXhkizII6tePPmeCk62pM75r1Ii/7ZVpKhsWBr/7jWo6FGNGt
 aIZDGy98EAel/lEUO7RyNAGX1swVN1Q=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-FiZtucNwMlu6b9OXrE_8rw-1; Fri, 19 May 2023 07:48:37 -0400
X-MC-Unique: FiZtucNwMlu6b9OXrE_8rw-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-50bcb45f749so3235322a12.2
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 04:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684496917; x=1687088917;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tyAqPOA30jlygdwot+rINyW6Md0cSwyA2f+ayCCD3uk=;
 b=bTG7YZfBnmKxatmXvpKSs8+h0wnHDyf1HLuLCewQ4J3cXYLpc/ViZa9ebDo+anFpaz
 n61IjIo8gAcAOL0rzGiGU2oqU3N5yeZ+TC0SMvqaYsiBW7dQL9obnAVnTOIdRUuEkm0F
 +hkJ20Foq//7o4jGnGUumaTUH9n9PdjR2Th6JFNI3p3sI/bNtgAzZpnfXc4VI4WVvS3a
 26GMmGfeQoljOvzEEqhFjXwAgC/TRw/PZsmxpwY2EqGCES/yNRoBMCX1VU/oc1/mO8dH
 YsuGmAMvNJUC/0p+PmbbDQaJ7Nx1+XDB9RDPxz1NG6EjERTGWgUOKcvg+Nk5gqSuiLcE
 2MXQ==
X-Gm-Message-State: AC+VfDzFr32pSePRLRMRYT8FXQy+zl0AC6OTv3fwlmyMz2G9lB+gSB78
 cdfePyY9Pqb5cUw2k+7gNIwLd0nqvLwaulT7Q1W65Tv8hfOdBXLURczNDe2MxJHLMdqOj+1TovF
 H0qcN8oA9DgSnvOg=
X-Received: by 2002:a05:6402:f:b0:510:f132:5c98 with SMTP id
 d15-20020a056402000f00b00510f1325c98mr1322133edu.17.1684496916811; 
 Fri, 19 May 2023 04:48:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7q+Qmm+Z2Ip9mIuHkjuDvZfkmPM0TSzPmo4+W2+hXsoBwTQYgHlUTSoOFM9XDxPpkJduLTrQ==
X-Received: by 2002:a05:6402:f:b0:510:f132:5c98 with SMTP id
 d15-20020a056402000f00b00510f1325c98mr1322116edu.17.1684496916440; 
 Fri, 19 May 2023 04:48:36 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89?
 ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.googlemail.com with ESMTPSA id
 g17-20020a056402181100b0050bc5acfcc0sm1607185edy.24.2023.05.19.04.48.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 May 2023 04:48:35 -0700 (PDT)
Message-ID: <8c5c87b0-79e3-02c1-b093-3d636a9853b0@redhat.com>
Date: Fri, 19 May 2023 13:48:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 0/6] meson: use subprojects for bundled projects
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com,
 richard.henderson@linaro.org, Thomas Huth <thuth@redhat.com>
References: <20230519085647.1104775-1-pbonzini@redhat.com>
 <CAFEAcA-nMG_5u4pADASoQNF_MCCXHMCB3APTtVLohzTzCmJ3cQ@mail.gmail.com>
 <ZGdCL3Ka2JSeo+XD@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <ZGdCL3Ka2JSeo+XD@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.527, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 5/19/23 11:32, Daniel P. Berrangé wrote:
> Feels like we should be able to figure out some way to get rid of all
> the submodules though, except for the roms, which are special and ok to
> leave IMHO

Hmm, almost.  roms/SLOF is used to build 
pc-bios/s390-ccw/s390-netboot.img, so right now GIT_SUBMODULE and 
GIT_SUBMODULE_ACTION could not be removed even without counting the 
tests/fp submodules.  That's about 10,000 lines of code, or about 20% of 
all of SLOF; it might be a bit too much for vendoring.

Adding Thomas for ideas...

Paolo


