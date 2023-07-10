Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B3F74D408
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 12:57:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIoZn-0006QQ-AP; Mon, 10 Jul 2023 06:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIoZk-0006Pu-JF
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 06:57:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIoZi-0005P1-OP
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 06:57:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688986621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pvdk6l0pQOkgAunW+CpQBKT3M0XdWI+dNEx7ZEjvAZU=;
 b=jPFnLW7UvEqWNwyggc1MabZ+13UJIQqn0mDayJCLyzJKwvBhn/yFSxJlJe9PIMmi7Moa3q
 hVVW4fcwAhYd10x2RaWhIE002yEZWWtnYWYJvPt/pOe3E0b6XYMww7UKnN72XQTsq3ixL6
 DUYt9qsKT5NF75d0zllgTotejX/afKg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-_jx_3rgdNQWrIDbzsJH3SA-1; Mon, 10 Jul 2023 06:57:00 -0400
X-MC-Unique: _jx_3rgdNQWrIDbzsJH3SA-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-763c36d4748so400615285a.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 03:57:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688986620; x=1691578620;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pvdk6l0pQOkgAunW+CpQBKT3M0XdWI+dNEx7ZEjvAZU=;
 b=PSVl9qxm6TnLZvr9eL3XPEvnV0UM1bCfjlVZVUMEqCGOoBa+wB2iGYhausjXt3pDS3
 rZqdeD1V6gctHmC/wzdKYIWlIcsW6c8cXz27pNZE3T3loqckhgvQgrj9NC5GEBpbTiJe
 31YXO6L8EMTwZviXpBY9lB3e5s5gcSMQdrQllCML7Ozz5Ys4RMyrk30Z8iGyYMn9WtEw
 9GjX8DZiIILfI8lSGD5kdmO4RObphQhJxXdGxHhFpf+xesTU2CpsWnasCTVWeLg6nepW
 P0ViAUup3BFR67zH6htw+B5oVwN1uyAGkgokTOxt/HAbuWsVDJe6yMdE78yE1FFnaskq
 P9oQ==
X-Gm-Message-State: ABy/qLYrwtNwfrwRlBaiuhHSCIjwaQ46qYUJJiVGp7iKiijsNrsHgefW
 cJrrvRgBB49I+UGas7xVAILx6FVSZgIkMUCRFcD2z7vcXfsG6tj/EJQlk7uX81GR1UKAGx/Ig6C
 jSdNPQXfJFMADaXk=
X-Received: by 2002:a05:620a:31a3:b0:767:2e2b:b4ff with SMTP id
 bi35-20020a05620a31a300b007672e2bb4ffmr12413129qkb.52.1688986620115; 
 Mon, 10 Jul 2023 03:57:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGMmuT0z6x9IeecaZslr5Y7pzBOY/BNZP3dZJb/2FcG7fxRA7d/F6xwpsaNP1TZP2U9FQDPGQ==
X-Received: by 2002:a05:620a:31a3:b0:767:2e2b:b4ff with SMTP id
 bi35-20020a05620a31a300b007672e2bb4ffmr12413114qkb.52.1688986619846; 
 Mon, 10 Jul 2023 03:56:59 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-179-116.web.vodafone.de.
 [109.43.179.116]) by smtp.gmail.com with ESMTPSA id
 l9-20020ae9f009000000b00767cd764ecfsm1966219qkg.33.2023.07.10.03.56.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 03:56:59 -0700 (PDT)
Message-ID: <2f176448-5dcf-1093-401f-9205ac5ec61b@redhat.com>
Date: Mon, 10 Jul 2023 12:56:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 4/4] QGA VSS: Add log in functions begin/end
Content-Language: en-US
To: Konstantin Kostiuk <kkostiuk@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230710091439.1010553-1-kkostiuk@redhat.com>
 <20230710091439.1010553-5-kkostiuk@redhat.com>
 <CAPMcbCq8LcQaaSptFzCaCcBs0qpss72GbLWkvSw22T7hwH9k9A@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <CAPMcbCq8LcQaaSptFzCaCcBs0qpss72GbLWkvSw22T7hwH9k9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.101, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 10/07/2023 12.38, Konstantin Kostiuk wrote:
> Hi Thomas,
> 
> Do you have any other comments about this commit?

Looks good to me now!

Reviewed-by: Thomas Huth <thuth@redhat.com>


