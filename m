Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B60B709B5A
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 17:31:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q023c-0003Ly-IG; Fri, 19 May 2023 11:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q023Q-0003Ks-08
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:30:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q023N-0006sK-Od
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:30:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684510200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=StDpbLx9aet7irn1+W+4I4yPAETvztkcBSBo5+e2uos=;
 b=N4gy8NRMNg6hClGDgElzQsEoLTXrezG6DtPw33lKO6vfdgl3jKFj9vaXTtDoJLztjhdo4x
 XQtk4j/ItTY0a3g+Nd5669rvvpdICoJu35cBQxWmVJFfIslkXZjIP+MYhVk+3u18kibUZ9
 isRoKy7nkZF6CaCkJjwzMpA6nNO5QUc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-qcNO0fk0OEa22LfipU-pQg-1; Fri, 19 May 2023 11:29:58 -0400
X-MC-Unique: qcNO0fk0OEa22LfipU-pQg-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-50bcb45f749so3453799a12.2
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 08:29:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684510197; x=1687102197;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=StDpbLx9aet7irn1+W+4I4yPAETvztkcBSBo5+e2uos=;
 b=SkTYDUkqNMTJyhas5h8JxnhxcMlpWkR1+pDaVqGJAhxlNAuSbHFgHtufH0Y07oQPaO
 lRofI95kJGOpEOH7N8fBQRsBLSLTe9A5q7FVnKEyF2b6rmoWYthf3ucdf3J323Nly85K
 rotXndJeoImbxPY9Tns/y/UzRpH/gPtyY+P70oGzhEwdeP+PAYFC6GpfivB3iKYaj22P
 Elt0QwrcirmEuTXVnt/ZJ15Vv0NjrTe9Bz3mTwSOSNWETdKb/Y+tUizlZn/TeU8Y6+7Q
 RU70Iji0RjBczBcN9MAMR0V3SsnFgV0nWfKMeboxhGfJa6tlewB0BPFmREjKyfZeChQh
 7sjA==
X-Gm-Message-State: AC+VfDxSsTxAKFSmjqd3wi7lQyPDulroJmS6K9w6wziZy5/tzaNwIB6i
 50NA4A8hNNkmX16AQrVzAymIrpvE3lNt2vDijf6p344LZGS03HzhFjH4NclPOtCxfZKyeIGJTCr
 RTarz0BSbuYMp1ac=
X-Received: by 2002:a50:ee95:0:b0:504:8905:5218 with SMTP id
 f21-20020a50ee95000000b0050489055218mr1970626edr.1.1684510197506; 
 Fri, 19 May 2023 08:29:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4g+j4ZS4JFTkhvO1u97l0b6a1HjEMYOUdTkCYv1SvpTXHntc7sJywDel2WweZkb7mpn+EIZw==
X-Received: by 2002:a50:ee95:0:b0:504:8905:5218 with SMTP id
 f21-20020a50ee95000000b0050489055218mr1970611edr.1.1684510197225; 
 Fri, 19 May 2023 08:29:57 -0700 (PDT)
Received: from ?IPV6:2003:cf:d723:b0c7:8fa2:ce55:2d0c:5fa3?
 (p200300cfd723b0c78fa2ce552d0c5fa3.dip0.t-ipconnect.de.
 [2003:cf:d723:b0c7:8fa2:ce55:2d0c:5fa3])
 by smtp.gmail.com with ESMTPSA id
 a1-20020aa7d741000000b00506987c5c71sm1798803eds.70.2023.05.19.08.29.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 May 2023 08:29:56 -0700 (PDT)
Message-ID: <3fb8db7b-aa51-8701-e0e8-b6b6d37c4c42@redhat.com>
Date: Fri, 19 May 2023 17:29:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 15/19] cutils: Set value in all qemu_strtosz* error
 paths
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, richard.henderson@linaro.org
References: <20230512021033.1378730-1-eblake@redhat.com>
 <20230512021033.1378730-16-eblake@redhat.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230512021033.1378730-16-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.527, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 12.05.23 04:10, Eric Blake wrote:
> Making callers determine whether or not *value was populated on error
> is not nice for usability.  Pre-patch, we have unit tests that check
> that *result is left unchanged on most EINVAL errors and set to 0 on
> many ERANGE errors.  This is subtly different from libc strtoumax()
> behavior which returns UINT64_MAX on ERANGE errors, as well as
> different from our parse_uint() which slams to 0 on EINVAL on the
> grounds that we want our functions to be harder to mis-use than
> strtoumax().
>
> Let's audit callers:
>
> - hw/core/numa.c:parse_numa() fixed in the previous patch to check for
>    errors
>
> - migration/migration-hmp-cmds.c:hmp_migrate_set_parameter(),
>    monitor/hmp.c:monitor_parse_arguments(),
>    qapi/opts-visitor.c:opts_type_size(),
>    qapi/qobject-input-visitor.c:qobject_input_type_size_keyval(),
>    qemu-img.c:cvtnum_full(), qemu-io-cmds.c:cvtnum(),
>    target/i386/cpu.c:x86_cpu_parse_featurestr(), and
>    util/qemu-option.c:parse_option_size() appear to reject all failures
>    (although some with distinct messages for ERANGE as opposed to
>    EINVAL), so it doesn't matter what is in the value parameter on
>    error.
>
> - All remaining callers are in the testsuite, where we can tweak our
>    expectations to match our new desired behavior.
>
> Advancing to the end of the string parsed on overflow (ERANGE), while
> still returning 0, makes sense (UINT64_MAX as a size is unlikely to be
> useful); likewise, our size parsing code is complex enough that it's
> easier to always return 0 when endptr is NULL but trailing garbage was
> found, rather than trying to return the value of the prefix actually
> parsed (no current caller cared about the value of the prefix).
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>
> ---
>
> v2: cutils.c unchanged, but rebasing test suite is significant enough
> that I doropped Hanna's R-b
> ---
>   tests/unit/test-cutils.c | 106 +++++++++++++++++++--------------------
>   util/cutils.c            |  17 +++++--
>   2 files changed, 63 insertions(+), 60 deletions(-)

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


