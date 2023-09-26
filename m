Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E627AEFDE
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 17:44:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlADW-0006h6-T2; Tue, 26 Sep 2023 11:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlADT-0006et-Iz
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 11:43:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlADO-0003yg-SO
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 11:43:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695742989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0iE+IIv4XjhAyDSFuVdj9n26KdkGoA148A/fVZUTxe8=;
 b=GWntJ+S0aK25B1v6JGn2gjOUQHyzwuh4EeA0ncllSnZvYf5asOooVqUCwNsnfnKcJ8JVYl
 RMY8TEvelexIwT86wwjJ5OkHKlv8GUamSTssZaBAvhwVSME4gvQviIFvx9LNYbH8BVjXUR
 6xjkIX+v53rA2u5JrT1kd24oUfmV9AI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-h-9qpDzFNYOhNoug2XF7RQ-1; Tue, 26 Sep 2023 11:43:07 -0400
X-MC-Unique: h-9qpDzFNYOhNoug2XF7RQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-31f3eaa5c5eso6710213f8f.3
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 08:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695742986; x=1696347786;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0iE+IIv4XjhAyDSFuVdj9n26KdkGoA148A/fVZUTxe8=;
 b=q8S3tTMGLbgyibBxWDoMd/9cdm5WdvVh3k1WotXBNiCG98+YvQp7FbMJrUvyVbWEes
 tX5EynYmV2Yc3dMaNp4mVQIajpq/Yyi7u7CRnmujvKxxq0jMS2RpHEgkA/DKa6+dOvve
 ESsoAbTIPzZpwKjGZ5CcIfaj5OXdUS9sOndT4DH5+Qt5dXWjrjtJfclF2VeAM/OZWjN5
 q+ODVvZRcAOrcCEOYDqMwigvHoVjwwzcs4pVeL06h3cUkjhBrIf+bOie0gLYNVYia9xn
 x4pJ/30XYUPRh/trxQKAxvH5Ci+fDtpqQ5xpjmTHS1Roo7QGo4O5SKWJQcl65WeFyJX3
 1xLg==
X-Gm-Message-State: AOJu0YyRGqqjau2R+lxhtozgm9a3vL5u+XFIf23NXpL17UndC/8k3enN
 VWaR0m11tbRFsfFbou0PE81fEQwOuvwXFbJ7asUhHbF6cV6DbEJImbatpd0Pz/P9qPnvM7iFF66
 2dvnZMmHEmepOe/0=
X-Received: by 2002:adf:f485:0:b0:31d:c3d2:4300 with SMTP id
 l5-20020adff485000000b0031dc3d24300mr9109161wro.71.1695742986241; 
 Tue, 26 Sep 2023 08:43:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkqO/b1on/ra1vSm3DcsL6+cjCyZ5kF9ZIbPnTGxyHfE0bEgROENnNRtFw5W/CkUojr1pe1A==
X-Received: by 2002:adf:f485:0:b0:31d:c3d2:4300 with SMTP id
 l5-20020adff485000000b0031dc3d24300mr9109147wro.71.1695742985918; 
 Tue, 26 Sep 2023 08:43:05 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89?
 ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.googlemail.com with ESMTPSA id
 z5-20020a7bc7c5000000b004060f0a0fd5sm2881166wmk.13.2023.09.26.08.43.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Sep 2023 08:43:05 -0700 (PDT)
Message-ID: <3ad9da3b-e91a-9c94-78a6-8c1550c943e9@redhat.com>
Date: Tue, 26 Sep 2023 17:43:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [v2] Help wanted for enabling -Wshadow=local
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, Brian Cain <bcain@quicinc.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <87y1gtnggy.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <87y1gtnggy.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/26/23 16:42, Markus Armbruster wrote:
> Overall Audio backends
> M: Gerd Hoffmann<kraxel@redhat.com>
> M: Marc-André Lureau<marcandre.lureau@redhat.com>
>      audio/audio.c

I can handle this too, but I first need to send out my next pull request.

Paolo


