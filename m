Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E63473E3E3
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 17:48:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDoO9-0005qR-Fh; Mon, 26 Jun 2023 11:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDoNz-0005hC-Fy
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:44:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDoNx-0003mS-NR
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:44:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687794247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7jbtZMjs4+6nWM78/SqZzXJgRhpc/5PUhvaBpcR47zo=;
 b=MsRrOS64NT/BtO/ddCXR60TarHQxQH3lyYZaajxkjJck+AJVuiorPR0Gr/oQmLn1GRarAK
 s5UG61E1NZuVnN79vG8Y2hJi7ozY7R7tuR45HjhIlmgjhcMEXsjpCsI8XuARPXWxs2Yknj
 Ihe30vw+EvXixQLIYxZOFKc58T2h/OQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-xeDZaGUqOgOGRUsVYp-nfg-1; Mon, 26 Jun 2023 11:44:04 -0400
X-MC-Unique: xeDZaGUqOgOGRUsVYp-nfg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-313f371b0d9so493750f8f.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 08:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687794243; x=1690386243;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7jbtZMjs4+6nWM78/SqZzXJgRhpc/5PUhvaBpcR47zo=;
 b=UMbzlXaXI6aZ0nrmPSTq6r45oRZwX3VwUTWBnf8Xz5vLcY9gnp9+5dbYRimBObMrc6
 LTV1Y12jXkVqGdMVG6vmMG5Qi+PT7CS+HOgpBhoLbK+Hhu3sDSnli6Nw1aovczJDYBcd
 tebZv4dMBMwGtN5LjauPcVkXEirJB1vL305DqpzBxb76uanaZCAE5KqZJnJxhOrsDRFJ
 bhNnSkYPI2JSvBq4oYFUgaPtvEdU5pql0MQzHOBSB7bq6vblzJK40OjXnda5yYRhmNzF
 FkirmBlVJZuo8x0Hjt4NyumsTHi2eN4DqPKFcWSVCZFDN2RmXQVHqECoeRZNt9ojkvgQ
 v2LQ==
X-Gm-Message-State: AC+VfDyyz2tY7BeuKkoYaJr0bpPHscVOwz/X9oFVEjgf2JuvF08iNhWz
 hPw6vfiajX66ho7JncrhtHt2Mzlv/t16rXHzznCcYphA1UJJWRJ+Yb+FeX1O+KaD7NrpLUO9ixv
 dVKVffFejzlwV6KA=
X-Received: by 2002:a5d:6506:0:b0:313:e953:65d0 with SMTP id
 x6-20020a5d6506000000b00313e95365d0mr4528127wru.28.1687794243569; 
 Mon, 26 Jun 2023 08:44:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5m/PBKfz3iOkbn0KyI7D9fXRx7Og9JCCyBYhoSxcpLoA84NS7IfJzRAtgHI3LOCL4aWeoisA==
X-Received: by 2002:a5d:6506:0:b0:313:e953:65d0 with SMTP id
 x6-20020a5d6506000000b00313e95365d0mr4528113wru.28.1687794243255; 
 Mon, 26 Jun 2023 08:44:03 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e?
 ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.googlemail.com with ESMTPSA id
 v10-20020a5d590a000000b002fda1b12a0bsm7816243wrd.2.2023.06.26.08.44.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 08:44:02 -0700 (PDT)
Message-ID: <875b2da3-3f9e-b0b2-3ed0-4c09310c6c0c@redhat.com>
Date: Mon, 26 Jun 2023 17:43:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 26/26] docs/devel: introduce some key concepts for QOM
 development
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
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
 <0c245101-77cf-9e9a-3c84-0293a75125b6@redhat.com> <87cz1i2vhg.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <87cz1i2vhg.fsf@linaro.org>
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

On 6/26/23 15:39, Alex Bennée wrote:
>> There were review comments on this series that haven't been applied.
> Sorry I'd missed those. I've fixed that for the respin which is
> currently checking on CI.

Still not exactly what I asked for; please remove the "The Device Class" 
heading (just the heading, the content is good there) and change "API 
Reference" to an "======" heading.

Thanks,

Paolo


