Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D29706DA8
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 18:09:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzJiF-0000ms-43; Wed, 17 May 2023 12:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ernunes@redhat.com>)
 id 1pzJi8-0000lz-Gt
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:09:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ernunes@redhat.com>)
 id 1pzJi4-0001EW-PT
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684339743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ilDjS9klTZpjO8SOISeYy7qBWKTPIeNYUaJfjIeHMiE=;
 b=ZnQAqqqyrazaaTaO4lRkCMLnq1foWkGHLNB0KOyCOZbFJ5r+p5yoAjiON6btKwWhKY5GAI
 6O/qzfCBPbDIWpGPfFmSO5SR972recNNXoPusj6BL1z+EThen/r8Xb6uEkyGlJg9ArFRxa
 HhDEt3KSohhs5neYLTTpMgHD4vREL9Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-7DBT_cH9NaO1pqflKAIQmg-1; Wed, 17 May 2023 12:09:02 -0400
X-MC-Unique: 7DBT_cH9NaO1pqflKAIQmg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-30479b764f9so414858f8f.0
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 09:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684339741; x=1686931741;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ilDjS9klTZpjO8SOISeYy7qBWKTPIeNYUaJfjIeHMiE=;
 b=WNtEH+fIfcSDoW3c+01ZzVN0fxVUBTGo+gnYrzs3Vqxl2iW+hdABeWKUnfpYXBDTCS
 mbOmIP+yuRzmUHpkcKFISqMve3ve0/cXyuODdNnP+XwrWPRBxKJiq9rh2s3y0/ltF6Fb
 NEQJek0F0DKfpfZ0MPBpFtPwV2opkDSB6+MxUDzyO0hCxXKaBlZxMcVDhBPAXZzpmzab
 bOl6OGyM7flTGMCTobSOOj68C5xRHcawVG1lhGrlxXZBiTxhvrs/ktBXHD+uPZSdFI4L
 IoN7MAHstdUlqA5ALuEc7jKBKhyTvFFEURRMYkcf7tJnTYQgHY0GMz5RILviAToeFbYs
 bSrg==
X-Gm-Message-State: AC+VfDzC1xDRTgpkOL7x3xDlzNChd6eMCxdvj+nWSRTuXFwuzMIdEq41
 cC2b/+5FyCXJMHmgs576fFAOHhgcOMXi/xXYPfcdyVNrNy8Kr69NN01tPotIRSfKm9DI6Twofe0
 FS76ccGKIQkhPOxs=
X-Received: by 2002:adf:eec5:0:b0:307:a24f:c15e with SMTP id
 a5-20020adfeec5000000b00307a24fc15emr1275731wrp.39.1684339741208; 
 Wed, 17 May 2023 09:09:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5PP6ejMo44B7eneT2YTix0t+LgHJhm4gBeaC4bERo+DqQUg5slE8eK7Bzat/8OmMGvsv18PQ==
X-Received: by 2002:adf:eec5:0:b0:307:a24f:c15e with SMTP id
 a5-20020adfeec5000000b00307a24fc15emr1275714wrp.39.1684339740922; 
 Wed, 17 May 2023 09:09:00 -0700 (PDT)
Received: from [10.0.0.6] (ip-78-45-66-209.bb.vodafone.cz. [78.45.66.209])
 by smtp.gmail.com with ESMTPSA id
 g3-20020a5d6983000000b002ff2c39d072sm3178181wru.104.2023.05.17.09.09.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 May 2023 09:09:00 -0700 (PDT)
Message-ID: <c42827cb-5201-1e2e-1dae-099527081d60@redhat.com>
Date: Wed, 17 May 2023 18:08:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/2] vhost-user-gpu get_edid feature
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, kraxel@redhat.com
References: <20230511125803.594963-1-ernunes@redhat.com>
 <CAJ+F1CK8+kPrGZfhWnk=91tUQCAggH=qHXjZ73K9ZF0t-1aTBA@mail.gmail.com>
From: Erico Nunes <ernunes@redhat.com>
In-Reply-To: <CAJ+F1CK8+kPrGZfhWnk=91tUQCAggH=qHXjZ73K9ZF0t-1aTBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ernunes@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.412, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 15/05/2023 13:38, Marc-André Lureau wrote:
> However, I worry about using the new backend (calling GET_EDID) with an
> older front-end/QEMU. It may just hang, since
> vhost_user_gpu_handle_display() won't reply to unknown messages. That's
> what PROTOCOL_FEATURES were meant for, iirc. Can you check? thanks

Indeed as you say, there is a hang with older qemu.

From what I see there are the generic protocol_features and also a
vhost-user-gpu message for them. I assume it is so that we don't have to
add vhost-user-gpu specific features to the generic set?
In any case, the current vhost-user-gpu specific protocol_features
negotiation happens too late to enable or disable virtio-gpu features
(triggered by VHOST_USER_GPU_SET_SOCKET). I suppose we could move it
earlier to the time the generic protocol_features are negotiated,
through the callback hooks that already exist in the vhost-user layer
(not implemented so far by vhost-user-gpu though).
So I guess we could remove the protocol_features negotiation that is
currently triggered by VHOST_USER_GPU_SET_SOCKET and use that to prevent
exposing VIRTIO_GPU_F_EDID at all. Does that make sense?

Otherwise, if we keep exposing VIRTIO_GPU_F_EDID and just not sending
VHOST_USER_GPU_GET_EDID then the get_edid feature is not quite
functional overall, which doesn't sound too great.

Thanks

Erico


