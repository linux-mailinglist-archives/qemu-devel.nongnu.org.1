Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EE07C586F
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 17:47:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqbQi-0007bu-Vk; Wed, 11 Oct 2023 11:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qqbQd-0007bP-Aj
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 11:47:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qqbQb-0003P3-KB
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 11:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697039236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2BIGHuNT5pdTDVAymIRVB91WSeNxsurwhrYrygl5Wy0=;
 b=FMG31HGWG98O2HGOdEkVkJPDwLNnrxLYbEJ0bCmIPenvnYPHHNnnajk1HIcC2gGn5UXRFU
 SFfJJchd3p4FrpGLJiUYJXAva/z+6JvwilXsSTNSJcsb3/AajHiD8T1OU5g+reJ4SJBrO7
 7PlzI/ztQkcCH3sag20Jb6cYKEd7aOE=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-btrxqNkUODOen-qSQgd5MQ-1; Wed, 11 Oct 2023 11:47:14 -0400
X-MC-Unique: btrxqNkUODOen-qSQgd5MQ-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-59c09bcf078so106040917b3.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 08:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697039234; x=1697644034;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2BIGHuNT5pdTDVAymIRVB91WSeNxsurwhrYrygl5Wy0=;
 b=m/0QT3/TnNV/NPCccgxpU232eEuZRifCrblL5QVddEmBiCyYQZZ7dKrWxyKRWtzd08
 t3G5NIYb6AceQjxCcqpzW+ATLX+ofV/jzPGF9v8j3oQLGA7Lbznte9N008LFZNkOettM
 KIbtv2nQtMBxP5osLHCAmnyUTjHvOEI4x+wy1zqYAUb+P4f0PQQ4eu/gqH1JEqblxh/z
 e1eF8TBGumEHQkCyw2g6v5FBgPZmvHy9ZpEC09DZ2vQjXlWWfg+zTlj0/IGZDsv1Jtki
 fYKamhb/1g48phFegMxsgWfA7WieYV0w2Kh/QG4OBXO5RqPR3yLMIIFqtD7fUWInZJks
 7tjQ==
X-Gm-Message-State: AOJu0YxgwuGLPCLEd/hAxMttroiJRBcgBs8x0hLPuortGM8vRF8CCVs3
 b72h0QWxDZTJ9WSkHLlQKQnTXC+FlHGedzcgcA20TUP+idjhQlaG4QQQ8AzxtRZOFSIDIZYi56w
 ZpMp0HYPTjhmgVMs=
X-Received: by 2002:a81:78d3:0:b0:5a7:a817:be43 with SMTP id
 t202-20020a8178d3000000b005a7a817be43mr7111331ywc.6.1697039234251; 
 Wed, 11 Oct 2023 08:47:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8a9xz2+cOYnWGJRWQgmXAM0WAXQPOBZhgRYbnY2LYWXxK8MLQH0+Ty+OEQOOP5G+6lNMANA==
X-Received: by 2002:a81:78d3:0:b0:5a7:a817:be43 with SMTP id
 t202-20020a8178d3000000b005a7a817be43mr7111314ywc.6.1697039233982; 
 Wed, 11 Oct 2023 08:47:13 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-176.web.vodafone.de.
 [109.43.176.176]) by smtp.gmail.com with ESMTPSA id
 z7-20020a05620a100700b0076f19b9e96fsm5321367qkj.107.2023.10.11.08.47.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 08:47:13 -0700 (PDT)
Message-ID: <9b6aa276-e341-405a-8f85-7aee1955ab42@redhat.com>
Date: Wed, 11 Oct 2023 17:47:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] tests/qtest: Introduce qtest_resolve_machine_alias
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20231006123910.17759-1-farosas@suse.de>
 <20231006123910.17759-6-farosas@suse.de>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20231006123910.17759-6-farosas@suse.de>
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

On 06/10/2023 14.39, Fabiano Rosas wrote:
> The migration tests are being enhanced to test migration between
> different QEMU versions. A requirement of migration is that the
> machine type between source and destination matches, including the
> version.
> 
> We cannot hardcode machine types in the tests because those change
> with each release. QEMU provides a machine type alias that has a fixed
> name, but points to the latest machine type at each release.
> 
> Add a helper to resolve the alias into the exact machine
> type. E.g. "-machine pc" resolves to "pc-i440fx-8.2"
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   tests/qtest/libqtest.c | 16 ++++++++++++++++
>   tests/qtest/libqtest.h | 10 ++++++++++
>   2 files changed, 26 insertions(+)
> 
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index c0e4f05979..f2f1756de1 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -1522,6 +1522,22 @@ void qtest_cb_for_every_machine(void (*cb)(const char *machine),
>       }
>   }
>   
> +char *qtest_resolve_machine_alias(const char *var, const char *alias)
> +{
> +    struct MachInfo *machines;
> +    int i;
> +
> +    machines = qtest_get_machines(var);
> +
> +    for (i = 0; machines[i].name != NULL; i++) {
> +        if (machines[i].alias && g_str_equal(alias, machines[i].alias)) {
> +            return g_strdup(machines[i].name);

Looking at this twice, I think there is no need for the g_strdup() here, 
since the name strings won't go away. You could then maybe also change the 
return type to "const char *".

  Thomas


> +        }
> +    }
> +
> +    return NULL;
> +}
> +
>   bool qtest_has_machine_with_env(const char *var, const char *machine)
>   {
>       struct MachInfo *machines;
> diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
> index 083b2a6520..75f9310bb0 100644
> --- a/tests/qtest/libqtest.h
> +++ b/tests/qtest/libqtest.h
> @@ -894,6 +894,16 @@ void qtest_qmp_fds_assert_success(QTestState *qts, int *fds, size_t nfds,
>   void qtest_cb_for_every_machine(void (*cb)(const char *machine),
>                                   bool skip_old_versioned);
>   
> +/**
> + * qtest_resolve_machine_alias:
> + * @var: Environment variable from where to take the QEMU binary
> + * @alias: The alias to resolve
> + *
> + * Returns: the machine type corresponding to the alias if any,
> + * otherwise NULL.
> + */
> +char *qtest_resolve_machine_alias(const char *var, const char *alias);
> +
>   /**
>    * qtest_has_machine:
>    * @machine: The machine to look for


