Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7361B719849
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 12:06:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4fAn-0005oq-4B; Thu, 01 Jun 2023 06:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4fAk-0005og-Cw
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 06:04:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4fAi-0000Ji-7M
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 06:04:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685613883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bKdcqpfaYAMLO2bg6oB59tRKjV3VuqjNTMa/XBA0jt0=;
 b=h8waoetKVOQXp4eLiw3NM1JLLZv0t5UkrRDs0gD+gjqCRJmSWzr/qxjKQa1SRXF0GYUNEn
 qeorqVFmJLlEqV6ArLovQLSU0NVlf588bn1dLRZSoGbzHJyuiR7nV+QFSRDWyHxP3MkJcs
 wxueETkpwfgHaoGp9l6wX3dPDePMmXA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-AKZY5RhtMQmwXCQC4f4Eyw-1; Thu, 01 Jun 2023 06:04:36 -0400
X-MC-Unique: AKZY5RhtMQmwXCQC4f4Eyw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f70f9995aeso4571735e9.0
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 03:04:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685613876; x=1688205876;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bKdcqpfaYAMLO2bg6oB59tRKjV3VuqjNTMa/XBA0jt0=;
 b=bSm7pXnVOHdkwAb/eCg/5aGfbaMNvnRlJ8FpQLNK81A10iYVE0KSE03JVCHaWbPgfQ
 4axmUfZ8Gf4oc4sX10OWaTU4fVrkISjGWnzKdT3dnvwD/k+YykpGeKVxlfe5y676RYDa
 4ip07BeRXp4DeYScepUdQJLe+U2qPQuul88nuqGc6+sYRVnn1KWmKQzdKfbNBqE0PUJs
 10pV778PxdRRptOHEgZ830HcAd0LbdfTSSGCsK4QZJJolOTK0/3DY8J4B4ZAxlr+ooom
 6xKVw/IDhPd2+pDdnZQZ9RROH1MZC0QBVWLQe6tafPREaL3fkBG3Zmj6NM2M2TQRgxeC
 gpwA==
X-Gm-Message-State: AC+VfDyJ5ziv8k3EP8FI7g55/O7q8VhNt+RDy8gB/qca+jMZ/wEq0k0G
 ToPuKjg2KN/bxN8fX5CoTaxf/citPslKImDlvm+b5BeHo48dDnIQ3Pu5QuBbMKICTJ1Jj2Rhm0U
 JZ4YL8ODEbf7mPeY=
X-Received: by 2002:a1c:f01a:0:b0:3f7:5e3:c1f8 with SMTP id
 a26-20020a1cf01a000000b003f705e3c1f8mr1448080wmb.2.1685613875857; 
 Thu, 01 Jun 2023 03:04:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Mhc0szG+bAyA0X5HE6ghPK71yQATNDCzmAVZIO7AHTv+Uv5XC35ODg4vlN++oYVyrLME0LA==
X-Received: by 2002:a1c:f01a:0:b0:3f7:5e3:c1f8 with SMTP id
 a26-20020a1cf01a000000b003f705e3c1f8mr1448069wmb.2.1685613875519; 
 Thu, 01 Jun 2023 03:04:35 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-178-86.web.vodafone.de.
 [109.43.178.86]) by smtp.gmail.com with ESMTPSA id
 m11-20020a7bce0b000000b003f1958eeadcsm1773738wmc.17.2023.06.01.03.04.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 03:04:34 -0700 (PDT)
Message-ID: <ce154c2c-6059-5669-1aff-a2af73a707d6@redhat.com>
Date: Thu, 1 Jun 2023 12:04:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 9/9] tests/qtest: massively speed up migration-test
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230531132400.1129576-1-berrange@redhat.com>
 <20230531132400.1129576-10-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230531132400.1129576-10-berrange@redhat.com>
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

On 31/05/2023 15.24, Daniel P. Berrangé wrote:
> The migration test cases that actually exercise live migration want to
> ensure there is a minimum of two iterations of pre-copy, in order to
> exercise the dirty tracking code.
> 
> Historically we've queried the migration status, looking for the
> 'dirty-sync-count' value to increment to track iterations. This was
> not entirely reliable because often all the data would get transferred
> quickly enough that the migration would finish before we wanted it
> to. So we massively dropped the bandwidth and max downtime to
> guarantee non-convergance. This had the unfortunate side effect

convergence

> that every migration took at least 30 seconds to run (100 MB of
> dirty pages / 3 MB/sec).
> 
> This optimization takes a different approach to ensuring that a
> mimimum of two iterations. Rather than waiting for dirty-sync-count

minimum

> to increment, directly look for an indication that the source VM
> has dirtied RAM that has already been transferred.
> 
> On the source VM a magic marker is written just after the 3 MB
> offset. The destination VM is now montiored to detect when the

monitored

...
> @@ -445,6 +459,91 @@ static void migrate_ensure_converge(QTestState *who)
>       migrate_set_parameter_int(who, "downtime-limit", 30 * 1000);
>   }
>   
> +/*
> + * Our goal is to ensure that we run a single full migration
> + * iteration, and also dirty memory, ensuring that at least
> + * one further iteration is required.
> + *
> + * We can't directly synchronize with the start of a migration
> + * so we have to apply some tricks monitoring memory that is
> + * transferred.
> + *
> + * Initially we set the migration bandwidth to an insanely
> + * low value, with tiny max downtime too. This basically
> + * guarantees migration will never complete.
> + *
> + * This will result in a test that is unacceptably slow though,
> + * so we can't let the entire migration pass run at this speed.
> + * Our intent is to let it run just long enough that we can
> + * prove data prior to the marker has been transferred *AND*
> + * also prove this transferred data is dirty again.
> + *
> + * Before migration starts, we write a 64-bit magic marker
> + * into a fixed location in the src VM RAM.
> + *
> + * Then watch dst memory until the marker appears. This is
> + * proof that start_address -> MAGIC_OFFSET_BASE has been
> + * transferred.
> + *
> + * Finally we go back to the source and read a byte just
> + * before the marker untill we see it flip in value. This

until

It's indeed much faster now, thank you very much for tackling this!

Tested-by: Thomas Huth <thuth@redhat.com>



