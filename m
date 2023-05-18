Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0ADC707C95
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 11:17:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzZke-0003FK-VL; Thu, 18 May 2023 05:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzZkZ-0003DV-1k
 for qemu-devel@nongnu.org; Thu, 18 May 2023 05:16:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzZkX-00032F-9X
 for qemu-devel@nongnu.org; Thu, 18 May 2023 05:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684401399;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=87TMTXOR9FUqZcXYpRzOvuNWu+Rdv+ilsmoJ8eGSK48=;
 b=I9KobdVMcnW1myAhRHLexKKFiCTYeXDdNFWrDTrESdembzblFeqqqMSu7Y35E57PIsUiXt
 z0sl9NrGMB+5Oyv+62wdhOWRI+KYdXcdbG1fwNChroF2ctdXc2w6ZI5ou7YjRPYsNyy2eh
 RuDHKr+41I45zMunR/CuigTlIkLP4N4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-Mp2LUXBfMOyuUikuEPJgzA-1; Thu, 18 May 2023 05:16:37 -0400
X-MC-Unique: Mp2LUXBfMOyuUikuEPJgzA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f421cfb4beso7203595e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 02:16:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684401396; x=1686993396;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=87TMTXOR9FUqZcXYpRzOvuNWu+Rdv+ilsmoJ8eGSK48=;
 b=Yrba5AaSjFCQnGp9yimwPBa2Fo2I5NSPeTRV6gPK7/zWarEmgPTvH6aNX2j+zTYH3v
 q80YcqZb/Urw5yKd1g0gOWVsAFJrzAH5HaoqjgQi22RLigPRSx6kZMN8F/t3YPwqvoAB
 rlRO8Mg46O0guGtnWYdNA1iq55y1W/K8TbEf71bwI9UNriR23Yi2dytBAEAu99TToBWv
 nVpiJn8ETEvjAP8DtlAARJIEKbUCXdh1v+tFlhj5BOjAWD2lki/UTHgRypEWF1cS1C9g
 VMQTxqfNZICtiq4i+gB9HRqRTYmPIbXFdbropRUL5iVPITuVDOYi2N333PKKO14mdPoh
 GPEg==
X-Gm-Message-State: AC+VfDyI0Hfw4qU0Dh4sygsvk5aa+yhtimt9WwRXfekMJG5yGFweydMi
 JR35ejqfpb6VSeY1nndFjbWay4kgE4jv1z96GArSEohAELypWJu9gwAFMfHuBO4oXL4s20bPq2R
 hnP+INQYctvlGyKA=
X-Received: by 2002:a1c:f701:0:b0:3f4:2572:225f with SMTP id
 v1-20020a1cf701000000b003f42572225fmr955635wmh.29.1684401396196; 
 Thu, 18 May 2023 02:16:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4oLIJrk0TmJKIfh8bC12ipZikwgEEG2WqX0Vasu5eJobOsBsQQSlNY2VvQslAL61WyelD5HQ==
X-Received: by 2002:a1c:f701:0:b0:3f4:2572:225f with SMTP id
 v1-20020a1cf701000000b003f42572225fmr955615wmh.29.1684401395849; 
 Thu, 18 May 2023 02:16:35 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 f2-20020a1cc902000000b003f50237bd9csm4746805wmb.19.2023.05.18.02.16.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 02:16:35 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Lei Wang <lei4.wang@intel.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 wei.w.wang@intel.com, Daniel Berrange <berrange@redhat.com>
Subject: Re: [PATCH] multifd: Set a higher "backlog" default value for listen()
In-Reply-To: <20230518085228.172816-1-lei4.wang@intel.com> (Lei Wang's message
 of "Thu, 18 May 2023 04:52:28 -0400")
References: <20230518085228.172816-1-lei4.wang@intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 18 May 2023 11:16:34 +0200
Message-ID: <87h6saf18t.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Lei Wang <lei4.wang@intel.com> wrote:
> When destination VM is launched, the "backlog" parameter for listen() is set
> to 1 as default in socket_start_incoming_migration_internal(), which will
> lead to socket connection error (the queue of pending connections is full)
> when "multifd" and "multifd-channels" are set later on and a high number of
> channels are used. Set it to a hard-coded higher default value 512 to fix
> this issue.
>
> Reported-by: Wei Wang <wei.w.wang@intel.com>
> Signed-off-by: Lei Wang <lei4.wang@intel.com>

[cc'd daiel who is the maintainer of qio]

My understanding of that value is that 230 or something like that would
be more than enough.  The maxiimum number of multifd channels is 256.

Daniel, any opinion?

Later, Juan.

> ---
>  migration/socket.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/migration/socket.c b/migration/socket.c
> index 1b6f5baefb..b43a66ef7e 100644
> --- a/migration/socket.c
> +++ b/migration/socket.c
> @@ -179,7 +179,7 @@ socket_start_incoming_migration_internal(SocketAddress *saddr,
>      QIONetListener *listener = qio_net_listener_new();
>      MigrationIncomingState *mis = migration_incoming_get_current();
>      size_t i;
> -    int num = 1;
> +    int num = 512;
>  
>      qio_net_listener_set_name(listener, "migration-socket-listener");


