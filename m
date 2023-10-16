Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 405EA7CA5F0
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 12:42:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsL1u-0004KW-Oz; Mon, 16 Oct 2023 06:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qsL1t-0004JT-Ba
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 06:40:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qsL1r-0006Bm-IY
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 06:40:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697452854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nuLc3JNKUPU6qCKAeOkSf3NPsNpp2F52f8pqJvv4wmk=;
 b=PNxmevLIiko6Sp6D42ec7IMeviyG2oofl+DJh5nSuYgMvZ5wu2rtCF+tdfE8l5SK21BGqC
 5vUKiQ9jrVjeyoXuW64bS700TNky7JSlsOXvHuRLaXI5akLd/vCRbKLv4HGu2DdQxAmhdB
 yC64yzfBJPqX4GlsUGlrZ9GKllJ2F9I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-HTPAfyK-PjiCBq74tDADjw-1; Mon, 16 Oct 2023 06:40:51 -0400
X-MC-Unique: HTPAfyK-PjiCBq74tDADjw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-31f79595669so2325551f8f.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 03:40:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697452850; x=1698057650;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nuLc3JNKUPU6qCKAeOkSf3NPsNpp2F52f8pqJvv4wmk=;
 b=YMZWqfHBuWJx2kjp9IWCSLJCA3jC2EeL1lelzN0bZVuOjO9pr15jnN+pFqN4UL8Pfs
 3nibY6urtx/MFJmlRYi+4fz/RSviABseRNmGG9ti4pTCE7XQG8I/mYVuqBXzy0NKl1Yy
 QGxoxETVErcvDM5fvs0VjyfUNGTpn9FtzwiZsMyH+yvJsAgxJEz66nGGxZGL9pB5A+id
 7mMS6Ti0Qo72HyeBBtF3tZmg7VaOPzDWOtIMA4nC41zRdA9A/UvdktZHTZ/cVYTZIZoL
 zeadCFN/+f/gtcGMqd7COxX61Q++Zz/ERkx+xASbPaTySE+C/nJcygCBkkEK4EpAzce/
 gwSA==
X-Gm-Message-State: AOJu0YweJspC0zexVqR0o6YNFfylgjH+SamON0YCGkn3lm86ffY1w4s1
 rLASqAXxFgc/qtopDjmiQ4Mg97dXRV0tUF2wfSSLaFmCWWbFhUe9qviO1vDyxqrcqwcuOex1TXj
 tRqnQV9BOltf2LJI=
X-Received: by 2002:adf:e412:0:b0:319:5234:5c92 with SMTP id
 g18-20020adfe412000000b0031952345c92mr4715770wrm.35.1697452850050; 
 Mon, 16 Oct 2023 03:40:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxoGeME/XyjGD6HNabaXcQlV37RYpofEyRjb2y8yfYfVZxpUYroX/mH86iPy2OfZqwVXkmmg==
X-Received: by 2002:adf:e412:0:b0:319:5234:5c92 with SMTP id
 g18-20020adfe412000000b0031952345c92mr4715756wrm.35.1697452849779; 
 Mon, 16 Oct 2023 03:40:49 -0700 (PDT)
Received: from ?IPV6:2003:cf:d746:c551:3d67:278e:c0a1:87a2?
 (p200300cfd746c5513d67278ec0a187a2.dip0.t-ipconnect.de.
 [2003:cf:d746:c551:3d67:278e:c0a1:87a2])
 by smtp.gmail.com with ESMTPSA id
 e6-20020a5d65c6000000b0032326908972sm10840946wrw.17.2023.10.16.03.40.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 03:40:49 -0700 (PDT)
Message-ID: <2ab61a59-846e-9d31-d04a-eef6567237b4@redhat.com>
Date: Mon, 16 Oct 2023 12:40:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] vhost-user: Fix protocol feature bit conflict
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Albert Esteve
 <aesteve@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Alex_Benn_=c3=a9_e?=
 <alex.bennee@linaro.org>
References: <20231016083201.23736-1-hreitz@redhat.com>
 <2m60m.9e9wlnnm01vd@linaro.org>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <2m60m.9e9wlnnm01vd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 16.10.23 10:45, Manos Pitsidianakis wrote:
> On Mon, 16 Oct 2023 11:32, Hanna Czenczek <hreitz@redhat.com> wrote:
>> diff --git a/include/hw/virtio/vhost-user.h 
>> b/include/hw/virtio/vhost-user.h
>> index 9f9ddf878d..1d4121431b 100644
>> --- a/include/hw/virtio/vhost-user.h
>> +++ b/include/hw/virtio/vhost-user.h
>> @@ -29,7 +29,8 @@ enum VhostUserProtocolFeature {
>>     VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS = 14,
>>     VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS = 15,
>>     VHOST_USER_PROTOCOL_F_STATUS = 16,
>> -    VHOST_USER_PROTOCOL_F_SHARED_OBJECT = 17,
>> +    /* Feature 17 reserved for VHOST_USER_PROTOCOL_F_XEN_MMAP. */
>> +    VHOST_USER_PROTOCOL_F_SHARED_OBJECT = 18,
>>     VHOST_USER_PROTOCOL_F_MAX
>> };
>
> May I ask, why not define VHOST_USER_PROTOCOL_F_XEN_MMAP as well 
> instead of a comment mention?

No particular reason, it’s just what I had planned to do for a while in 
other series that would introduce feature bits (e.g. 
https://lists.nongnu.org/archive/html/qemu-devel/2023-07/msg02452.html). 
I think I took that from libvhost-user, which does this for 
VHOST_USER_PROTOCOL_F_STATUS.

> Otherwise:
>
> Reviewed-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>

Thanks!

Hanna


