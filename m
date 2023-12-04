Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD8D802B20
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 05:56:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA10V-0006JY-SN; Sun, 03 Dec 2023 23:56:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA10R-0006H3-OY
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 23:56:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA10P-0005MI-CT
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 23:56:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701665788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O+3SZBblKfXkOi4LP60gDefOIh8eTU+V0b/iG10Kg14=;
 b=TjLnJS+/nsdrKCHkqptQ9mvzMMGeHDdln1mmmZw62c31kbo4zuQ+Gn7rbRWhjSzsQsO60+
 D0NKWVbYI9ylDEUUCK2MINxuMeDOCY/UNk7g6prhyCUInrtg9yVaYgbxf2W4oKBb3DiM/K
 77jQMNjTUqydjIyGjr+AkU7xtLx/cTw=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-X_etjzHhMVWEKPla5pB6zg-1; Sun, 03 Dec 2023 23:56:26 -0500
X-MC-Unique: X_etjzHhMVWEKPla5pB6zg-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1d0737b7262so4224055ad.1
 for <qemu-devel@nongnu.org>; Sun, 03 Dec 2023 20:56:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701665786; x=1702270586;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O+3SZBblKfXkOi4LP60gDefOIh8eTU+V0b/iG10Kg14=;
 b=KXHiqleGwOyGhlfcBBDAyIm8tXTKhsDWFZ7Wvvyh4QgI5gKXJSgvFuRIukRs60nBnM
 TbLQi5l0UDGFDYrLVWehGRWCjGmi4B2uw7b/o9MXiWcFCygT9f0Iv+2T3IOGpwspLUap
 6flgDr6QcQYRpgPxtKmFmb3gw4/4ilAZoyKtdkCxraAEcZ89CZX8svAu2Lxxdv9DFPva
 j0yGgwNWsZgXXlJdYjgbFBQKvRrv3NCjWIqGCn+jjA2hM3imkqgFnBwJUuCXxUdqFBXn
 UAfqarpLnyyrCOW/p64EM64DIBjaCxN9fluY87+4Np56TweEO5oHWq6Zgp2yS8Ys9OBj
 RSAg==
X-Gm-Message-State: AOJu0YyIqYHqjN/eBnXYnamXpG7ln/iWh+5Hsr+koNGnNmd+NDo9cmEv
 KqbqwpAVJXuIejMpdu2tuN+yVJk26NYb9D3M+WP+kCriUn0yzCx8B5q//YlQ07sKFC5ykYObepc
 BZ+fdUwBX7wkMbxk=
X-Received: by 2002:a17:902:c792:b0:1d0:77c9:a9bc with SMTP id
 w18-20020a170902c79200b001d077c9a9bcmr929311pla.37.1701665786024; 
 Sun, 03 Dec 2023 20:56:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqS4YRhB76NyUggCcnPdzy6AWlM5ctveoAbGuaaQZHVbdLShdvdxx/xhRBbmEW1nPlg44+1Q==
X-Received: by 2002:a17:902:c792:b0:1d0:77c9:a9bc with SMTP id
 w18-20020a170902c79200b001d077c9a9bcmr929304pla.37.1701665785760; 
 Sun, 03 Dec 2023 20:56:25 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 h21-20020a170902f7d500b001d058ad8770sm5298193plw.306.2023.12.03.20.56.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Dec 2023 20:56:25 -0800 (PST)
Message-ID: <a1cfd31d-111a-4897-8fc1-1d7efbaeb475@redhat.com>
Date: Mon, 4 Dec 2023 14:56:20 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 15/25] backends: Simplify
 host_memory_backend_memory_complete()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Peter Xu <peterx@redhat.com>
References: <20231120213301.24349-1-philmd@linaro.org>
 <20231120213301.24349-16-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231120213301.24349-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 11/21/23 07:32, Philippe Mathieu-Daudé wrote:
> Return early if bc->alloc is NULL. De-indent the if() ladder.
> 
> Note, this avoids a pointless call to error_propagate() with
> errp=NULL at the 'out:' label.
> 
> Change trivial when reviewed with 'git-diff --ignore-all-space'.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   backends/hostmem.c | 133 +++++++++++++++++++++++----------------------
>   1 file changed, 67 insertions(+), 66 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


