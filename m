Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F5173E0A3
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:29:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDmGC-000718-32; Mon, 26 Jun 2023 09:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDmG9-00070L-AD
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:28:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDmG7-0008Ss-Pw
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:28:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687786078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OtKrSIn4YG4Jneb8ljOeRTxWL6q5v4yI+SCt392+1vA=;
 b=H6ulSTE/HxqM5fgw5yO7oi9tmEq1N8MDE532o7XU+n+IqjmXTAyE/VLJTiXuXKV8oGnJr7
 zmTd4CdZkqbHrKhLJNK3xQJF5iDYltW+hmYIKoezfKOlzzzElPy7kMxwnnlghnpl+j8Adq
 9dyR8jNnHY9dNbAzhOLJQ8xh3JjfQXA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-kk05hx-4NTGpLagAiwEXDg-1; Mon, 26 Jun 2023 09:27:56 -0400
X-MC-Unique: kk05hx-4NTGpLagAiwEXDg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4fb76659cacso725348e87.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 06:27:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687786075; x=1690378075;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OtKrSIn4YG4Jneb8ljOeRTxWL6q5v4yI+SCt392+1vA=;
 b=k//ADZKKOjOmXRFqeUG7eouLlh5iEd8RFXA3J/Mh+iptTPcZ6yumQmEWZ73sGc2yit
 RaDxYtYbXDfmuuK87ugRP/wGsh3kjMQ+wdpB4DgM76J3XPec1thoibB8oYgTLW+p76vY
 rTXuiNTvgt8wce6gGK6HmktOZmj03/XCTxHSaOIynilT4jAUWKSmA5BFUI7lRmc2LTSl
 tWT8bjZrAmhowUb3iMBTXcCT9ykY33FMjTAptjfXGHrgX9jDGkEwtpsZ275wXD6/u/MM
 KLp/97TrKFWLzKjlpe0s6991XQnOY0YaWSubDmWgH4ACUSUcFeNXlk/Vg3eJXyaYdqZq
 LpQw==
X-Gm-Message-State: AC+VfDxYwqiCzIX/nj/JandkQ8+2Pr17c+AXEYkqqUMhxm08aa+OIsXJ
 KEnG9BYW2PYNJUKWjyw10bT9aj3x5Y/g0PH5MVHSJTQb8YkLp8xe/4UXJpatYeTye7pJ9VkPa1N
 4KUe6xsTR5XpkN1M=
X-Received: by 2002:a19:7b02:0:b0:4f6:1b45:e8aa with SMTP id
 w2-20020a197b02000000b004f61b45e8aamr16840691lfc.50.1687786075284; 
 Mon, 26 Jun 2023 06:27:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ796QqiBwj9PLSMQWWBzPFKJZPEzBo27YtRtf+X8hLEV/52l5ftenpRkgS+W8oWsLBCp6udiw==
X-Received: by 2002:a19:7b02:0:b0:4f6:1b45:e8aa with SMTP id
 w2-20020a197b02000000b004f61b45e8aamr16840645lfc.50.1687786074903; 
 Mon, 26 Jun 2023 06:27:54 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e?
 ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.googlemail.com with ESMTPSA id
 o11-20020a05600c378b00b003fa95f328afsm3136331wmr.29.2023.06.26.06.27.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 06:27:54 -0700 (PDT)
Message-ID: <0c245101-77cf-9e9a-3c84-0293a75125b6@redhat.com>
Date: Mon, 26 Jun 2023 15:27:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 26/26] docs/devel: introduce some key concepts for QOM
 development
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Peter Xu <peterx@redhat.com>, qemu-arm@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>, Riku Voipio <riku.voipio@iki.fi>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Bandan Das <bsd@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Bulekov <alxndr@bu.edu>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Qiuhao Li
 <Qiuhao.Li@outlook.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Yanan Wang <wangyanan55@huawei.com>
References: <20230623122100.1640995-1-alex.bennee@linaro.org>
 <20230623122100.1640995-27-alex.bennee@linaro.org>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230623122100.1640995-27-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/23/23 14:21, Alex Bennée wrote:
> Using QOM correctly is increasingly important to maintaining a modern
> code base. However the current documentation skips some important
> concepts before launching into a simple example. Lets:
> 
>    - at least mention properties
>    - mention TYPE_OBJECT and TYPE_DEVICE
>    - talk about why we have realize/unrealize
>    - mention the QOM tree
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> Message-Id:<20230619171437.357374-6-alex.bennee@linaro.org>

There were review comments on this series that haven't been applied.

Paolo


