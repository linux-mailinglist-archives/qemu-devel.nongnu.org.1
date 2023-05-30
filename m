Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A506716BB9
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 19:58:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q43bA-0006yz-Rj; Tue, 30 May 2023 13:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q43b8-0006yF-KJ
 for qemu-devel@nongnu.org; Tue, 30 May 2023 13:57:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q43b7-0001dl-BE
 for qemu-devel@nongnu.org; Tue, 30 May 2023 13:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685469448;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=VLVmWbjrMa40KaUzNJRuTWQzLVE/QBmNWXk1sVGajGc=;
 b=Ck5bU0oUm0+U1GY9QFaCUhT4mY7YvXg+Of0+rXzhFtKozrGbRc/GeXLZJPWv9ppTFvz7u4
 +YMIq9yynuAMIqOV1rHCWADJ5LuFUNJhTu0CGUyyr7ToGBxa5MaByfol2r7AdbyEp7VJeI
 HgCHTomsJey7sZXubzbjo54bSNiOb0s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-fi3F8fo-OGaIxBIHFwrvRA-1; Tue, 30 May 2023 13:57:27 -0400
X-MC-Unique: fi3F8fo-OGaIxBIHFwrvRA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30ad885addcso27593f8f.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 10:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685469446; x=1688061446;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VLVmWbjrMa40KaUzNJRuTWQzLVE/QBmNWXk1sVGajGc=;
 b=cXDOGBPk1fHMUGhm/RueCwcid1lS7cED/I3ODPzygsqWAFyzNEYIqTU6+NV5pGWgG1
 t4N6p8NmK56CgncPxc2J90Kd5P+UvCXMHVlZ6LfNQH6Nq9HwvW8nubDNLpcQNs+S2CmC
 lIuUKUWqoC8N97aKVG4djmuEHW3HTfudxs5aGTNnJlOhN6BdvFeY0N5U1dfnuKtgShVX
 majFvcoRo1JggIVIxlkyQmbfV+9JKpS+0O817mAe2Vv8WDAeahMQEe+neFrWdPgSBUUT
 nWYqvdB8GAtLQs/VPH5/bGWWLr8MpQ4GK28c8rw97vDH7/6YfYGGp/HXkWo7i3lmJ3TE
 o3zA==
X-Gm-Message-State: AC+VfDwU2923BfYBMkpHkIoTpZReIzmg/vU2g/MiT4fBcPPBP0Tv28XC
 i0oqEqLiHt2nRcJqT6pL+NIg1JpJq5lYW2xY1duY4Hs0OPnSj7jlpvBMHxoZCA3W6SR4whPiPcN
 rD9ddHINNWoWFGks=
X-Received: by 2002:a5d:62c5:0:b0:303:daff:f1a3 with SMTP id
 o5-20020a5d62c5000000b00303dafff1a3mr10277747wrv.1.1685469446197; 
 Tue, 30 May 2023 10:57:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4gQvJNKCS9YZ+ENMKMSk4MqmrwP2BaceQDZs77U/iprLNEedvFvrT+niWh4au2oU582WYbPA==
X-Received: by 2002:a5d:62c5:0:b0:303:daff:f1a3 with SMTP id
 o5-20020a5d62c5000000b00303dafff1a3mr10277733wrv.1.1685469445931; 
 Tue, 30 May 2023 10:57:25 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 o5-20020a1c7505000000b003f6f6a6e769sm11670105wmc.17.2023.05.30.10.57.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 10:57:25 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  Leonardo Bras
 <leobras@redhat.com>,  Hailiang Zhang <zhanghailiang@xfusion.com>,  Peter
 Xu <peterx@redhat.com>,  Fam Zheng <fam@euphon.net>,  Stefan Hajnoczi
 <stefanha@redhat.com>
Subject: Re: [PATCH 10/16] qemu-file: Remove _noflush from
 qemu_file_transferred_noflush()
In-Reply-To: <87a5xmarsq.fsf@suse.de> (Fabiano Rosas's message of "Tue, 30 May
 2023 10:10:29 -0300")
References: <20230530122813.2674-1-quintela@redhat.com>
 <20230530122813.2674-11-quintela@redhat.com> <87a5xmarsq.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Tue, 30 May 2023 19:57:24 +0200
Message-ID: <87r0qxvh17.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
>> qemu_file_transferred() don't exist anymore, so we can reuse the name.
>>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/qemu-file.h | 4 ++--
>>  migration/block.c     | 4 ++--
>>  migration/qemu-file.c | 2 +-
>>  migration/savevm.c    | 6 +++---
>>  migration/vmstate.c   | 4 ++--
>>  5 files changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/migration/qemu-file.h b/migration/qemu-file.h
>> index b4fb872018..3575dfa5ff 100644
>> --- a/migration/qemu-file.h
>> +++ b/migration/qemu-file.h
>> @@ -34,7 +34,7 @@ QEMUFile *qemu_file_new_output(QIOChannel *ioc);
>>  int qemu_fclose(QEMUFile *f);
>>  
>>  /*
>> - * qemu_file_transferred_noflush:
>> + * qemu_file_transferred:
>>   *
>>   * As qemu_file_transferred except for writable files, where no flush
>
> Docs need updating^

Fixed, thanks.

>>   * is performed and the reported amount will include the size of any
>> @@ -42,7 +42,7 @@ int qemu_fclose(QEMUFile *f);
>>   *
>>   * Returns: the total bytes transferred and queued
>>   */
>> -uint64_t qemu_file_transferred_noflush(QEMUFile *f);
>> +uint64_t qemu_file_transferred(QEMUFile *f);


