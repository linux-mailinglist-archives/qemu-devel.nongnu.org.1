Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9060F76D2E8
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 17:51:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRE7X-0001nw-Ie; Wed, 02 Aug 2023 11:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qRE7V-0001n8-6E
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 11:50:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qRE7T-0000LW-Rc
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 11:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690991438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HEpIYFHNxUe8Q0wFMm3dpFygaPhTyRuRyMi1P68K4h4=;
 b=OYplmkH8N8erYmWmHZiu65jL68NwzHrxTH52kA2GjNH7go9d8owtETO4EaLcTFTbT1wofb
 D/iY/AdSWjxXDvUwYKP+cCa0wark/3pIBNs7fu5xo4ZNHmCclFvjoDmdzTr55PGtlMjRjo
 wNMxm5tCGkoa8Q4SVsmPyPZubz1UYBk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-dEpYh0Z6NG2Z7YCT_krRDw-1; Wed, 02 Aug 2023 11:50:37 -0400
X-MC-Unique: dEpYh0Z6NG2Z7YCT_krRDw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-5eee6742285so85237576d6.2
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 08:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690991436; x=1691596236;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HEpIYFHNxUe8Q0wFMm3dpFygaPhTyRuRyMi1P68K4h4=;
 b=HlilcdiVxYsod9M+aiQP3UHgHiixgua9o5jNR4rMB5eBgySAPgS6fBSaic+qmptcuQ
 +qpdoNNLGKI9e6hX2TedFX7zaxmU6WEp9AZv2Z2wyjrHCY9WoAEG58j1Zi9hyYIlm3wt
 iytpc/Ya7W/q6ai49p0gSKpggTqr+owqf+KYuF57/dzW9UIgXcaW1u4iWUJjT9lYHRFu
 QiulJEwLuwPxshQmvMCQ7Sw7MId7hnLjDTnRUN7hHOOhO4+yO4cKk/jm9lMG1I+gqO9m
 M8KOLkB1u05Ci0kCn7qZV7GSqqKUS4Gwe2ZKgXNDEa2JgWcDGhlsdvErGieeEAgg/i2b
 Ll2w==
X-Gm-Message-State: ABy/qLbLw+cfmjyTGu0cLMsuBdvoBFVJHR+CoqPDCCzyV6wT9TKfe+FJ
 Yauiog4IBtp1zRPzZFml/Hbg8NeUI2JdM80xY7yMjODObbh++oL0hw6RMUwUlHwhNm9bNjMQrHw
 036SuiLA+UgOXU44=
X-Received: by 2002:ac8:5bd3:0:b0:400:8e9d:106a with SMTP id
 b19-20020ac85bd3000000b004008e9d106amr21053770qtb.45.1690991436647; 
 Wed, 02 Aug 2023 08:50:36 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHWfPMO+dEUMcQFgyXmlwZv4RxCIp0ToEt/ofyh27Gzju06S7G4A8ef0BCwSkKg/rv4Y6yt6Q==
X-Received: by 2002:ac8:5bd3:0:b0:400:8e9d:106a with SMTP id
 b19-20020ac85bd3000000b004008e9d106amr21053748qtb.45.1690991436325; 
 Wed, 02 Aug 2023 08:50:36 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-178-230.web.vodafone.de.
 [109.43.178.230]) by smtp.gmail.com with ESMTPSA id
 i16-20020ac84890000000b0040554ed322dsm5346938qtq.62.2023.08.02.08.50.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Aug 2023 08:50:35 -0700 (PDT)
Message-ID: <af8ae8f7-087f-e638-f5cf-ec9ff1974390@redhat.com>
Date: Wed, 2 Aug 2023 17:50:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/8] gitlab: always populate cache for windows msys jobs
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20230801130403.164060-1-berrange@redhat.com>
 <20230801130403.164060-6-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230801130403.164060-6-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.102, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 01/08/2023 15.04, Daniel P. Berrangé wrote:
> The cache is used to hold the msys installer. Even if the build phase
> fails, we should still populate the cache as the installer will be
> valid for next time.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   .gitlab-ci.d/windows.yml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
> index 6454880cb7..34109a80f2 100644
> --- a/.gitlab-ci.d/windows.yml
> +++ b/.gitlab-ci.d/windows.yml
> @@ -8,6 +8,7 @@
>       key: "${CI_JOB_NAME}-cache"
>       paths:
>         - msys64/var/cache
> +    when: always
>     needs: []
>     stage: build
>     timeout: 80m

Reviewed-by: Thomas Huth <thuth@redhat.com>


