Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F3A71856A
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 16:58:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4NGR-00016F-FA; Wed, 31 May 2023 10:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4NGQ-000167-Bm
 for qemu-devel@nongnu.org; Wed, 31 May 2023 10:57:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4NGO-0001S9-Cb
 for qemu-devel@nongnu.org; Wed, 31 May 2023 10:57:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685545042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qjjS52B/t3oQf18UhFTf16HvgsGDOrKF+WSPf7VkSlM=;
 b=XbPPon3ktDEJY+ZK7F3BI4vI46dLDGISD/S+6ScHcHRls3sd5ry2+OfKvYLzeJh7SgmN6e
 G/rPTiWbhlVP4JG3i86V1GiczlEeRcJfuUVLBw8twzDupRCJK2gHRaL3myoHjeE2+0jA0w
 sCEVOIlgqvO4IH6FXdd4VjzFD/5yMog=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-OzRQ6ZH6NDKoS6W4xBVjBQ-1; Wed, 31 May 2023 10:57:20 -0400
X-MC-Unique: OzRQ6ZH6NDKoS6W4xBVjBQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30af222c5feso1422447f8f.1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 07:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685545038; x=1688137038;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qjjS52B/t3oQf18UhFTf16HvgsGDOrKF+WSPf7VkSlM=;
 b=ibfGcYZO/38MNhtfN45e6wMI/0oj0nZpnViksMmuUtFy65CDl22VIytCJZhW2Ie/LX
 0EfMj9EZZC73OsebBEwdUO0CBwTRva4admuihg7oYSbY+Bmeuay0Qoo61ipF0ARD0CNS
 gz9R1ntp6xIIGnullRlPe+tDQuMoX/4cuUrhlqDT2M5DMwe4L6BR+jp/zComa+HcWIfi
 +n5d9OCv/kiE3EHQ3YEMvTr7kBh4hjfL8CfZ/sEXBtD+urOKkIoNe8vkP3IWxEIdsNdX
 Aj4KVtjT3gLnC6fRJdOQHXC4m5cNHZxo0ZSB6qkjOXFPnvsWQGfJ0bWx8EN/wmEI62hc
 WRCQ==
X-Gm-Message-State: AC+VfDwlJT4r79Y5Ct6ZhWtsOdbIMQ1qhNey8GmRj/RVESYBPsegvcCb
 3v786EBCH5cDPGCWR310xfbLIjf656BHhVPZ2dnyHUMrRojVEQU8zql0ze34GCi5u9oGso2uEom
 RkM6kmdC1lV1tc70=
X-Received: by 2002:a05:6000:1942:b0:30a:d8f3:3e41 with SMTP id
 e2-20020a056000194200b0030ad8f33e41mr4157392wry.7.1685545037924; 
 Wed, 31 May 2023 07:57:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5P4mUnYnHky8SOLP2jF3WMcpFhMLUIF0SrwgKbnZBM7teFI1MvDOMkCnCAcYN1zKfhD8VIGA==
X-Received: by 2002:a05:6000:1942:b0:30a:d8f3:3e41 with SMTP id
 e2-20020a056000194200b0030ad8f33e41mr4157383wry.7.1685545037680; 
 Wed, 31 May 2023 07:57:17 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-178-4.web.vodafone.de. [109.43.178.4])
 by smtp.gmail.com with ESMTPSA id
 s16-20020adfeb10000000b0030630120e56sm7064931wrn.57.2023.05.31.07.57.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 07:57:17 -0700 (PDT)
Message-ID: <d239fa73-0a5b-7c08-f4ce-afbd5681ecfe@redhat.com>
Date: Wed, 31 May 2023 16:57:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 2/9] tests/qtest: add support for callback to receive
 QMP events
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230531132400.1129576-1-berrange@redhat.com>
 <20230531132400.1129576-3-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230531132400.1129576-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

On 31/05/2023 15.23, Daniel P. Berrangé wrote:
> Currently code must call one of the qtest_qmp_event* functions to
> fetch events. These are only usable if the immediate caller knows
> the particular event they want to capture, and are only interested
> in one specific event type. Adding ability to register an event
> callback lets the caller capture a range of events over any period
> of time.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/qtest/libqtest.c | 20 ++++++++++++++++++--
>   tests/qtest/libqtest.h | 37 +++++++++++++++++++++++++++++++++++--
>   2 files changed, 53 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index 603c26d955..1534177fc1 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -82,6 +82,8 @@ struct QTestState
>       GString *rx;
>       QTestTransportOps ops;
>       GList *pending_events;
> +    QTestQMPEventCallback eventCB;
> +    void *eventData;
>   };
>   
>   static GHookList abrt_hooks;
> @@ -703,8 +705,14 @@ QDict *qtest_qmp_receive(QTestState *s)
>           if (!qdict_get_try_str(response, "event")) {
>               return response;
>           }
> -        /* Stash the event for a later consumption */
> -        s->pending_events = g_list_append(s->pending_events, response);
> +
> +        if (s->eventCB) {
> +            s->eventCB(s, qdict_get_str(response, "event"),
> +                       response, s->eventData);
> +        } else {
> +            /* Stash the event for a later consumption */
> +            s->pending_events = g_list_append(s->pending_events, response);
> +        }
>       }
>   }
>   
> @@ -808,6 +816,14 @@ void qtest_qmp_send_raw(QTestState *s, const char *fmt, ...)
>       va_end(ap);
>   }
>   
> +void qtest_qmp_set_event_callback(QTestState *s,
> +                                  QTestQMPEventCallback cb, void *opaque)
> +{
> +    s->eventCB = cb;
> +    s->eventData = opaque;
> +}
> +
> +

Nit: Use one empty line only instead of two.

Apart from that:
Reviewed-by: Thomas Huth <thuth@redhat.com>



