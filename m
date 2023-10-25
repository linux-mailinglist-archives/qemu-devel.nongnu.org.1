Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD6B7D675C
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 11:46:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvaS0-0000ee-F1; Wed, 25 Oct 2023 05:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qvaRy-0000eS-62
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:45:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qvaRw-0005N2-6f
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698227113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RswpmtzEDCELtzF93E1ZOt9WKxUcwuSKVtpp+DEkhuU=;
 b=hMEWbk7Zo5MGyPw2CYqAYrj5TofaqATiU8eGkbboX1OxL2cYM7rLCk5uliALc1nNyHnPlJ
 f9fU47qZDvqjTVQH4XCc4Ke/tdgQbM832GKCpInRm01ocBZOkDHMoH21X2RKA8RP++HmaO
 O7t/c5kLLJhY/dpdRAnhAYpbw0j+WU4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-3s8IacxKNX6W7_CllIQdRg-1; Wed, 25 Oct 2023 05:45:12 -0400
X-MC-Unique: 3s8IacxKNX6W7_CllIQdRg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-65afd7515aaso75376036d6.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 02:45:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698227111; x=1698831911;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RswpmtzEDCELtzF93E1ZOt9WKxUcwuSKVtpp+DEkhuU=;
 b=CLPsIUq3EKyZFHU+vO7f0JEyFoTGlH6C+YQ9tNJgXEmdU2Wdf3JrPK4dBOwsxLiZZn
 vMT4UjUKa/B0pfH4O5dkPXl0q0mNzANmXNsf0fSNX0Lvywt7Dgeze9/9S0OthIwmn/8W
 dqySOw3seJH4dsyGKd7M2a924UYH6q8HvHnAjs4ssFi/AtNuVoAyFJ4DujNgPBKkZVdf
 ZON0lkIYmbS+0Kr9V+RvtA+Lm2OtsH0q99jP33c7wI/6FCLpi/TY3k9i6yaM68tJCX5J
 aW0JqBFXMgUipdIkii634FvEm/J7U8FURDRjwweKnmihOJCYlv+D6e5n5W36kTMhdq6D
 70JA==
X-Gm-Message-State: AOJu0YzhP1qUm/Glg8xAOGtHCSJjbyAyAPk6/wHp+2LdaLWKo1qNmD1I
 9bPJBzkRjkhoPJ9qfTOPpID2aFckAzXymF6lmInyJIZ6N3SXzE3cxGocSzEub9Fs1Ph4KFC2ZnP
 GZtHavSdPqqTQSkw=
X-Received: by 2002:a05:6214:c65:b0:65a:f55e:5a77 with SMTP id
 t5-20020a0562140c6500b0065af55e5a77mr16372247qvj.34.1698227111584; 
 Wed, 25 Oct 2023 02:45:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXga7yTkbGXrK8BUrs68sICSfM61c94RcLHAMDwcMbKmMZ1kShuxxAuJYESY4MeW9O6YYDUw==
X-Received: by 2002:a05:6214:c65:b0:65a:f55e:5a77 with SMTP id
 t5-20020a0562140c6500b0065af55e5a77mr16372227qvj.34.1698227111354; 
 Wed, 25 Oct 2023 02:45:11 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-176-238.web.vodafone.de.
 [109.43.176.238]) by smtp.gmail.com with ESMTPSA id
 m11-20020ad44b6b000000b0066cf4fa7b47sm4312505qvx.4.2023.10.25.02.44.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 02:45:02 -0700 (PDT)
Message-ID: <c7a5152a-1347-4d7d-bb01-9378eb4dad7e@redhat.com>
Date: Wed, 25 Oct 2023 11:44:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/29] tests/qtest: migration events
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 Steve Sistare <steven.sistare@oracle.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-2-farosas@suse.de>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20231023203608.26370-2-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 23/10/2023 22.35, Fabiano Rosas wrote:
> From: Steve Sistare <steven.sistare@oracle.com>
> 
> Define a state object to capture events seen by migration tests, to allow
> more events to be captured in a subsequent patch, and simplify event
> checking in wait_for_migration_pass.  No functional change.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   tests/qtest/migration-helpers.c | 24 ++++-------
>   tests/qtest/migration-helpers.h |  8 ++--
>   tests/qtest/migration-test.c    | 74 +++++++++++++++------------------
>   3 files changed, 46 insertions(+), 60 deletions(-)
> 
> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
> index 24fb7b3525..fd3b94efa2 100644
> --- a/tests/qtest/migration-helpers.c
> +++ b/tests/qtest/migration-helpers.c
> @@ -24,26 +24,16 @@
>    */
>   #define MIGRATION_STATUS_WAIT_TIMEOUT 120
>   
> -bool migrate_watch_for_stop(QTestState *who, const char *name,
> -                            QDict *event, void *opaque)
> -{
> -    bool *seen = opaque;
> -
> -    if (g_str_equal(name, "STOP")) {
> -        *seen = true;
> -        return true;
> -    }
> -
> -    return false;
> -}
> -
> -bool migrate_watch_for_resume(QTestState *who, const char *name,
> +bool migrate_watch_for_events(QTestState *who, const char *name,
>                                 QDict *event, void *opaque)
>   {
> -    bool *seen = opaque;
> +    QTestMigrationState *state = opaque;
>   
> -    if (g_str_equal(name, "RESUME")) {
> -        *seen = true;
> +    if (g_str_equal(name, "STOP")) {
> +        state->stop_seen = true;
> +        return true;
> +    } else if (g_str_equal(name, "RESUME")) {
> +        state->resume_seen = true;
>           return true;
>       }
>   
> diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
> index e31dc85cc7..c1d4c84995 100644
> --- a/tests/qtest/migration-helpers.h
> +++ b/tests/qtest/migration-helpers.h
> @@ -15,9 +15,11 @@
>   
>   #include "libqtest.h"
>   
> -bool migrate_watch_for_stop(QTestState *who, const char *name,
> -                            QDict *event, void *opaque);
> -bool migrate_watch_for_resume(QTestState *who, const char *name,
> +typedef struct QTestMigrationState {
> +    bool stop_seen, resume_seen;

Just a matter of taste, but for struct definitions, I'd prefer to put the 
entries on a single line each instead.

> +} QTestMigrationState;
> +
> +bool migrate_watch_for_events(QTestState *who, const char *name,
>                                 QDict *event, void *opaque);

  Thomas



