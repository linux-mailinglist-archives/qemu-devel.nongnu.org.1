Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D46FF7B7B00
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:04:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxaj-0002Vg-Kt; Wed, 04 Oct 2023 04:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qnxaQ-0002NM-RR
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:50:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qnxaP-0004yV-Eb
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409428;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=+nFdpYfSOPIQPh1l6gcUAWm78QQC23cww7qxxX7FCHs=;
 b=K80dqlWQnw5LgE/A+Gb/xTyEMvOiF6h/VZ+a8I5eayLIdqHHesj6+6zLI8R4/Zr/SGmMLZ
 jDJ8mjO94LulQysJpH7TbpWycYapEkmCAiXWmzpznXxZ+cmcICbojaMrbPUrOruYhaxWCK
 AUClpGHY8eEXlIoRCGSTuoPP/KG1RRg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-NoSUQd8BPcuxAS-GaETlwQ-1; Wed, 04 Oct 2023 04:50:27 -0400
X-MC-Unique: NoSUQd8BPcuxAS-GaETlwQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4066e59840eso12715945e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:50:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409426; x=1697014226;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+nFdpYfSOPIQPh1l6gcUAWm78QQC23cww7qxxX7FCHs=;
 b=kwamCvUUDPnbOYv9DXOShwV8TytpmQA9+5v1kngi8Bh+/EMqPU9AoKgPy5bT5rdu0h
 sDSzoj+bRiGS6aqKwPOea0qs95o0ebOl+VaVEnJ8Ae1UR99WfeSXXfpCp7NnCJIxHKGP
 GYuBQi7O+RvwyE7QhLbkuJk2LWLGKCRwTLTT541qZjSHmaiwtU5yyEF5DNZhyW4nl+ba
 qrNclWEXUHxJ5N/OmdqJ6SIPM5I5AE/rGlXLU1xaARaB9W4onTXvTjYmXJwgu8YIQPBC
 9BTfrgfoNOLulZmS6E+IxLnpF7btl38+lfNQj4u8ndT/wwfLh+fUnFSSyaXbNqinPiAH
 Pzzw==
X-Gm-Message-State: AOJu0YxYHmTj1Hgb0RNc4cxduCdRuqBUraKxEs2/aQv/GsUl8IiCOUny
 T5u/KMQDm3YSf7H9VgieAHXudtZK8O4DrD1Y6FNv7tCKtxuus61VqB6ndTTNSPaIDF3UPrE/5ES
 0YmgE7+EE5dBCvdc=
X-Received: by 2002:a05:600c:2211:b0:402:fec4:fddc with SMTP id
 z17-20020a05600c221100b00402fec4fddcmr1760599wml.17.1696409426410; 
 Wed, 04 Oct 2023 01:50:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6flEYuYUo41HImrpjHLzJdv9tkxo/sSY/RUM26h6tFl1Ge0joYzIAwX8kXpT0puROSVRe1g==
X-Received: by 2002:a05:600c:2211:b0:402:fec4:fddc with SMTP id
 z17-20020a05600c221100b00402fec4fddcmr1760586wml.17.1696409426090; 
 Wed, 04 Oct 2023 01:50:26 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 12-20020a05600c020c00b004063ea92492sm950263wmi.22.2023.10.04.01.50.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:50:25 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: Peter Xu <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>,
 qemu-devel@nongnu.org,  qemu-s390x@nongnu.org
Subject: Re: [PATCH v2 1/3] i386/a-b-bootblock: factor test memory addresses
 out into constants
In-Reply-To: <20230919102346.2117963-2-d-tatianin@yandex-team.ru> (Daniil
 Tatianin's message of "Tue, 19 Sep 2023 13:23:44 +0300")
References: <20230919102346.2117963-1-d-tatianin@yandex-team.ru>
 <20230919102346.2117963-2-d-tatianin@yandex-team.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 10:50:24 +0200
Message-ID: <87sf6q4vqn.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Daniil Tatianin <d-tatianin@yandex-team.ru> wrote:
> So that we have less magic numbers to deal with. This also allows us to
> reuse these in the following commits.
>
> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> Reviewed-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

queued.


