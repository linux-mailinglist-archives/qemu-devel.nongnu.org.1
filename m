Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8812F718729
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 18:16:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4OUR-0007yc-8O; Wed, 31 May 2023 12:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ernunes@redhat.com>)
 id 1q4OSq-000719-AM
 for qemu-devel@nongnu.org; Wed, 31 May 2023 12:14:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ernunes@redhat.com>)
 id 1q4OSo-0001kY-Kc
 for qemu-devel@nongnu.org; Wed, 31 May 2023 12:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685549657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mOGdo6Z/cP6eypmggAOurHpMCJPAEYWRHpbvmrQbNj8=;
 b=Q/P8lqGDds9NhRwRk1V9smdGh7Mi1zYZeLUUPmOThSGSwY6qhm5xVZ+H8dTIVxrXjiUNDY
 UP2PueBkzoPJuYxbCp2tubyobnIdugcL/3eyMeAVkuDoWhz1itZhu9sVZK/l9+slXIoJxW
 NvCFjiF78VkEEPArP340amq7IlyCCxg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-3Pw2Fn1bNfaPLPOcS5xC2Q-1; Wed, 31 May 2023 12:14:15 -0400
X-MC-Unique: 3Pw2Fn1bNfaPLPOcS5xC2Q-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-96f6fee8123so486301666b.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 09:14:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685549655; x=1688141655;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mOGdo6Z/cP6eypmggAOurHpMCJPAEYWRHpbvmrQbNj8=;
 b=klExs3iKqrz772hN6RXtKLuxWL7n/bTX7dezq7mnd5tciWQvbJUR02QisUqgZXPwM4
 1CJ+kqs0vQilInuW1lTbWB9z2Lvzsk7G03wRH38fbjtDxEbLGNiWgs20xB99TlIKE5fA
 Ek2+UdXKsl+dZVt8+K994IYwbmRUxPsMAmSrqnWMFw9orKcN76Jqd8Pk2/OGUiQbpIde
 IqjZ8UWpvV3VA4LUNgGex7auvf2XabFAXQlz8BzCWegCh1+2Fz0vBApKeDWQOmowofNW
 JWUPALE5EIM6uaI/rXYtgmtEXdZnpIyXQZ7pMufFjatVS0+WJPgmWebFtkci2IwZNI1c
 Z0lA==
X-Gm-Message-State: AC+VfDxfw7t35v7WQ+ae9hsvidboftLDaC0v1cYiQsR9RJp8/iq4nGb/
 tZOra7BNrB8rsx/ncvBpUNfDquiuVQL0BRIQSMPR2xs341+GR7gSgDweRmpDUbpKYbaIKo1N+D/
 WpLxuC/trfT453MU=
X-Received: by 2002:a17:907:160f:b0:974:1ced:6a59 with SMTP id
 hb15-20020a170907160f00b009741ced6a59mr5188586ejc.3.1685549654829; 
 Wed, 31 May 2023 09:14:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Qk0HCIsZk5bMUOhscMJXS9ZsN3RQmGOS0lK4WXbcwcENsK34642rTAsm8L4Mxe7sXKjhARQ==
X-Received: by 2002:a17:907:160f:b0:974:1ced:6a59 with SMTP id
 hb15-20020a170907160f00b009741ced6a59mr5188570ejc.3.1685549654568; 
 Wed, 31 May 2023 09:14:14 -0700 (PDT)
Received: from [10.43.17.57] (nat-pool-brq-t.redhat.com. [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id
 am10-20020a170906568a00b0096ae152115bsm9319830ejc.175.2023.05.31.09.14.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 09:14:13 -0700 (PDT)
Message-ID: <770c292c-9b74-fc68-19b4-09c806de1c4c@redhat.com>
Date: Wed, 31 May 2023 18:14:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/2] vhost-user-gpu get_edid feature
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, kraxel@redhat.com
References: <20230511125803.594963-1-ernunes@redhat.com>
 <CAJ+F1CK8+kPrGZfhWnk=91tUQCAggH=qHXjZ73K9ZF0t-1aTBA@mail.gmail.com>
 <c42827cb-5201-1e2e-1dae-099527081d60@redhat.com>
 <CAJ+F1C+eGxZtdu033HP-UdowLKrz94LdKwkRB=hfDm3amv1C-g@mail.gmail.com>
Content-Language: en-US
From: Erico Nunes <ernunes@redhat.com>
In-Reply-To: <CAJ+F1C+eGxZtdu033HP-UdowLKrz94LdKwkRB=hfDm3amv1C-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ernunes@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 24/05/2023 13:23, Marc-André Lureau wrote:
> Hi Erico
> 
> On Wed, May 17, 2023 at 8:09 PM Erico Nunes <ernunes@redhat.com
> <mailto:ernunes@redhat.com>> wrote:
> 
>     On 15/05/2023 13:38, Marc-André Lureau wrote:
>     > However, I worry about using the new backend (calling GET_EDID)
>     with an
>     > older front-end/QEMU. It may just hang, since
>     > vhost_user_gpu_handle_display() won't reply to unknown messages.
>     That's
>     > what PROTOCOL_FEATURES were meant for, iirc. Can you check? thanks
> 
>     Indeed as you say, there is a hang with older qemu.
> 
>     From what I see there are the generic protocol_features and also a
>     vhost-user-gpu message for them. I assume it is so that we don't have to
>     add vhost-user-gpu specific features to the generic set?
>     In any case, the current vhost-user-gpu specific protocol_features
>     negotiation happens too late to enable or disable virtio-gpu features
>     (triggered by VHOST_USER_GPU_SET_SOCKET). I suppose we could move it
>     earlier to the time the generic protocol_features are negotiated,
>     through the callback hooks that already exist in the vhost-user layer
>     (not implemented so far by vhost-user-gpu though).
>     So I guess we could remove the protocol_features negotiation that is
>     currently triggered by VHOST_USER_GPU_SET_SOCKET and use that to prevent
>     exposing VIRTIO_GPU_F_EDID at all. Does that make sense?
> 
> 
> Wouldn't this work?
> 
> If VIRTIO_GPU_F_EDID is set and during protocol_features the GET_EDID
> feature is not negotiated, exit the gpu backend with an error.

I sent v2 implementing it this way.
It seems that qemu always requests the virtio feature though (even if
you do pass edid=off to the device, it just doesn't expose it to the
user but does request the feature bit). So given we can't change past
qemu builds I'm not sure if there is a way to make an older qemu with an
updated vhost-user-gpu work at all. The new implementation does print an
error message in that case though.

Thanks

Erico


