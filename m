Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D27B7D4DC6
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 12:31:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvEg3-0004HQ-HF; Tue, 24 Oct 2023 06:30:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvEfv-00049u-Lz
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 06:30:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvEfo-0004i3-NG
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 06:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698143407;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=hwAobTLS/1UoHxh5+Q92tXJelKwlGoiE+xs/QCkMhRQ=;
 b=DZakJfvPwf8JsWo3yKfGEiCNj/MWpUBPY5fbGFssSBwF2gvvtNCzsxzQiKenomeTPIEoYq
 vgQGZGlPY/dB+dw3/yEQKX7zkpr2N7jbtoj1kptzh2WQIJ0almR63nYyB9q1RxtVuDFcRI
 OtAJ0gkPw4FW/XfttAvZ5ebjtMayKIU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-n9ZkkbZqOV67qY11JjJBXg-1; Tue, 24 Oct 2023 06:29:43 -0400
X-MC-Unique: n9ZkkbZqOV67qY11JjJBXg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-408f9cee5e8so17762095e9.0
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 03:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698143382; x=1698748182;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hwAobTLS/1UoHxh5+Q92tXJelKwlGoiE+xs/QCkMhRQ=;
 b=DXqXNYe6Y5SlPkdzOjJ/qHFm4LixDpmtTlOfEmxT1+cCxPUUogMbo+YZNbNtQn24Qw
 0L08/9+fvy/Qt61zmSoFG6TD1RdDpJsgzf9naw7PS/3RUMSXdMWIBUIujdLq6ZVEejh1
 Z4YURHYFprUVUzzWDYsU9QBYvpVpo6tZNub/kbYGj3gP/FNXHXAv/mT1kJxALm4hw/vV
 1KWC0OfoMgYWiT1JqplozzNfinaz7fdiBZLPpPZLtrG2vc0vwkWb3XNTC+QlBQQFOpfY
 PWsi5pdde8QHj3Fjjt/KUPj3v4tobp/KMovaeq1FI2Bkcv9nbjeKmMNh7B94xkEb7nu/
 5n6Q==
X-Gm-Message-State: AOJu0YyAPPdPDCaa9b1esgAXWODAMJ+6m7EYHIX7F/Z6CSmLEjVFeBZl
 fGkjfHrmRliD0NqYRyneb00uAy7ADEFT6OOV/uk8/RD3NIiVCIlkz+oGcIwjvVw/1HNnVgyQTnU
 BQiMR9iiMXKYXYe4=
X-Received: by 2002:a05:600c:35c7:b0:407:3b6d:b561 with SMTP id
 r7-20020a05600c35c700b004073b6db561mr8529772wmq.9.1698143382722; 
 Tue, 24 Oct 2023 03:29:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxxSOBm88AFxdbfCQhIiY5HxsmaK3M3xfaEw4QNiD4/jweJ1FWE1ZfBq7DxZDJLsvwaJRXnA==
X-Received: by 2002:a05:600c:35c7:b0:407:3b6d:b561 with SMTP id
 r7-20020a05600c35c700b004073b6db561mr8529764wmq.9.1698143382377; 
 Tue, 24 Oct 2023 03:29:42 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 p10-20020a05600c05ca00b004083729fc14sm16137693wmd.20.2023.10.24.03.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 03:29:41 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Leonardo Bras <leobras@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH v2 07/11] migration: Create compress_update_rates()
In-Reply-To: <874jih1lwt.fsf@suse.de> (Fabiano Rosas's message of "Mon, 23 Oct
 2023 10:57:38 -0300")
References: <20231019110724.15324-1-quintela@redhat.com>
 <20231019110724.15324-8-quintela@redhat.com> <874jih1lwt.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 24 Oct 2023 12:29:41 +0200
Message-ID: <87il6w1ffu.fsf@secure.mitica>
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

Fabiano Rosas <farosas@suse.de> wrote:
> Juan Quintela <quintela@redhat.com> writes:
>
>> So we can move more compression_counters stuff to ram-compress.c.
>> Create compression_counters struct to add the stuff that was on
>> MigrationState.
>>
>> Reviewed-by: Lukas Straub <lukasstraub2@web.de>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/ram-compress.h |  1 +
>>  migration/ram.h          |  1 -
>>  migration/ram-compress.c | 42 +++++++++++++++++++++++++++++++++++++++-
>>  migration/ram.c          | 29 +--------------------------
>>  4 files changed, 43 insertions(+), 30 deletions(-)
>>
>> diff --git a/migration/ram-compress.h b/migration/ram-compress.h
>> index b228640092..76dacd3ec7 100644
>> --- a/migration/ram-compress.h
>> +++ b/migration/ram-compress.h
>> @@ -71,5 +71,6 @@ void decompress_data_with_multi_threads(QEMUFile *f, void *host, int len);
>>  void populate_compress(MigrationInfo *info);
>>  uint64_t ram_compressed_pages(void);
>>  void update_compress_thread_counts(const CompressParam *param, int bytes_xmit);
>> +void compress_update_rates(uint64_t page_count);
>>  
>>  #endif
>> diff --git a/migration/ram.h b/migration/ram.h
>> index 145c915ca7..9cf8f58e97 100644
>> --- a/migration/ram.h
>> +++ b/migration/ram.h
>> @@ -34,7 +34,6 @@
>>  #include "io/channel.h"
>>  
>>  extern XBZRLECacheStats xbzrle_counters;
>> -extern CompressionStats compression_counters;
>>  
>>  /* Should be holding either ram_list.mutex, or the RCU lock. */
>>  #define RAMBLOCK_FOREACH_NOT_IGNORED(block)            \
>> diff --git a/migration/ram-compress.c b/migration/ram-compress.c
>> index f56e1f8e69..af42cab0fe 100644
>> --- a/migration/ram-compress.c
>> +++ b/migration/ram-compress.c
>> @@ -41,7 +41,20 @@
>>  #include "ram.h"
>>  #include "migration-stats.h"
>>  
>> -CompressionStats compression_counters;
>
> Could we remove CompressionStats from migration.json now?

No.

void populate_compress(MigrationInfo *info)
{
    if (!migrate_compress()) {
        return;
    }
    info->compression = g_malloc0(sizeof(*info->compression));
    info->compression->pages = compression_counters.pages;
    info->compression->busy = compression_counters.busy;
    info->compression->busy_rate = compression_counters.busy_rate;
    info->compression->compressed_size = compression_counters.compressed_size;
    info->compression->compression_rate = compression_counters.compression_rate;
}

I know that at this point you hate backwards compatibility O:-)

> Anyway:
> Reviewed-by: Fabiano Rosas <farosas@suse.de>

Thanks.


