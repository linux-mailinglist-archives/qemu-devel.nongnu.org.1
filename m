Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C076737BE5
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 09:09:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBrxL-00017u-DC; Wed, 21 Jun 2023 03:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qBrxI-00016E-Oz
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 03:08:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qBrxH-0006pc-2d
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 03:08:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687331318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sKco4T/GA7XGYLqZw2lpoJj//tNbzul91G89gk0KL/U=;
 b=QkPUVaXKCxjJuSChx26cM9gt0bQZRREFdq2eDJiyPyjoVgAIYap2bt33sInjJWTtgjSlZi
 O30Sm7K7zR9KyvS5njh4NfR8zfcRMEnPMiSdRa2Z6ywm0ciEvDZQIcGMYENgwYDObc3R9l
 9Gvp6YH5mIv/I0vbaAjRRc5tPGdnAv0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-B0_0lOxJOratBeR_UZetgw-1; Wed, 21 Jun 2023 03:08:36 -0400
X-MC-Unique: B0_0lOxJOratBeR_UZetgw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4f63eed2413so3994208e87.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 00:08:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687331315; x=1689923315;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sKco4T/GA7XGYLqZw2lpoJj//tNbzul91G89gk0KL/U=;
 b=MXWdVRSYS7E3ean3gOC+uHcf7R6CCgeGyakDBX+GP55yWbEYAMd586EDY9PP3/pWL/
 m50N310805P+WGgoao683LbkEBHqdNhXlBBTTMLVR0eUDOg7WzD+KUV9ZpTYgYYaEHrq
 hyXrlRa9gFd7R+ybsNoZWyBLOf12py7RhMPSamI9sXZUX0ILcKFgy5vMG+zOxi6siTVn
 ml+aCIiJ+Hq11jXHPp+c2y3+w78mCIM++Pa1333ieCLbbDD8FN4uTotMbTex/nsvN3CF
 esNly3T9gbvZHkBIS7iFa6uSOYduoanZJjADKmt7gD9rExzWz4afgzJLOfgrqFnaYS1n
 dteQ==
X-Gm-Message-State: AC+VfDz6TIGaiIhxUgatZsG3sF5U6V5Hm+6UCBrT2kMe4i8bvOKWYmo3
 060eWdAXRU5dXIR9N2mSlHfzadpu6bOFQCvYnkB5VrObGp6erKuFWfbcp/axs41D0swVOI3MqgK
 VOl4WdEDIqCi6H4g=
X-Received: by 2002:a19:5f05:0:b0:4f8:442c:de25 with SMTP id
 t5-20020a195f05000000b004f8442cde25mr7842039lfb.5.1687331315309; 
 Wed, 21 Jun 2023 00:08:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7ybjXMclxGmxa0+iB1VhFJOM4keYhG20kd6hWcZ6cenJ0/AKKB1oLCjHIQPgNO9IsMHcLifg==
X-Received: by 2002:a19:5f05:0:b0:4f8:442c:de25 with SMTP id
 t5-20020a195f05000000b004f8442cde25mr7842013lfb.5.1687331314847; 
 Wed, 21 Jun 2023 00:08:34 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 n12-20020a7bc5cc000000b003eddc6aa5fasm15222118wmk.39.2023.06.21.00.08.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Jun 2023 00:08:34 -0700 (PDT)
Message-ID: <e715e41d-b50a-3747-8007-e188e911a724@redhat.com>
Date: Wed, 21 Jun 2023 09:08:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC 4/6] migration: Deprecate -incoming <uri>
Content-Language: en-US
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, qemu-block@nongnu.org, Peter Xu <peterx@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>,
 Fam Zheng <fam@euphon.net>, libvir-list@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230612193344.3796-1-quintela@redhat.com>
 <20230612193344.3796-5-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230612193344.3796-5-quintela@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

On 12/06/2023 21.33, Juan Quintela wrote:
> Only "defer" is recommended.  After setting all migation parameters,
> start incoming migration with "migrate-incoming uri" command.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>   docs/about/deprecated.rst | 7 +++++++
>   softmmu/vl.c              | 2 ++
>   2 files changed, 9 insertions(+)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 47e98dc95e..518672722d 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -447,3 +447,10 @@ The new way to modify migration is using migration parameters.
>   ``blk`` functionality can be acchieved using
>   ``migrate_set_parameter block-incremental true``.
>   
> +``-incoming uri`` (since 8.1)
> +'''''''''''''''''''''''''''''
> +
> +Everything except ``-incoming defer`` are deprecated.  This allows to
> +setup parameters before launching the proper migration with
> +``migrate-incoming uri``.
> +
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index b0b96f67fa..7fe865ab59 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -2651,6 +2651,8 @@ void qmp_x_exit_preconfig(Error **errp)
>       if (incoming) {
>           Error *local_err = NULL;
>           if (strcmp(incoming, "defer") != 0) {
> +            warn_report("-incoming %s is deprecated, use -incoming defer and "
> +                        " set the uri with migrate-incoming.", incoming);
>               qmp_migrate_incoming(incoming, &local_err);
>               if (local_err) {
>                   error_reportf_err(local_err, "-incoming %s: ", incoming);

Could we maybe keep at least the smallest set of necessary parameters 
around? I'm often doing a "-incoming tcp:0:1234" for doing quick sanity 
checks with migration, not caring about other migration parameters, so if 
that could continue to work, that would be very appreciated.

  Thomas


