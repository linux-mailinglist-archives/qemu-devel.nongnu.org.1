Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B85EC75CD49
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 18:09:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMsh1-0004K3-9V; Fri, 21 Jul 2023 12:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qMsgy-0004JE-O1
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 12:09:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qMsgw-0007BQ-BY
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 12:09:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689955757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tOR5CKyow9NUa3dQySTSpujhl6X/94tkMShMMxhhzXs=;
 b=ZjqCpMbOX0qEm09BZfGEPDZK4RA7+ZbwRvNLZx3fPb7X4fGd7I/BtbFeuND94b6hVzpZfl
 +U9WW5dsICfcXu+pLTwpSNJA2L+ybfQrVLmJwlJB4le2bxjsZkfz8yagiXGC7WoevE9L+v
 nhbemh/lx+gGHU5Cx39uoLhYC47qebY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-PIiZj_TxNZuKmYmmu7OCoA-1; Fri, 21 Jul 2023 12:09:16 -0400
X-MC-Unique: PIiZj_TxNZuKmYmmu7OCoA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-99ab59eef1fso155341566b.2
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 09:09:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689955755; x=1690560555;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tOR5CKyow9NUa3dQySTSpujhl6X/94tkMShMMxhhzXs=;
 b=M3n7/x5FdU6jYJtUb+Rz/WnfJUYpIdwKPW3kZ2NCzlHAPHN4Ulc2xuj9fxOmZV9Ye3
 OJSGvHr/86GDwh+GYjaOfxI2sv2Dts7MvFLg0V5NHF6W/Q88lSHYoYNnGeaYMIiP7+hY
 XluxsjqyrGxl0HQFUOpeDDLsMdoGCm+pYtmDI5fJwXCXnnde12TvMk7DN7aG4gsaaKs1
 6sASFpeqJvVnpKtHVRe0YAgJJ7lzdClhiY7RMb8VjXWYtvo5gsWk6CFlsBm/XSdaY+VU
 hElJmLU5tJjvKnGIwI1fNMWB/qGnUeU4ScUqFsNam+vvWVdgnghQ7LaMVK9UUHCEw1C7
 1Nwg==
X-Gm-Message-State: ABy/qLbnXXITnTGJb7023IcHdUeQIG/RlkULUN17x+fRnA7yvh29FUsE
 LbG266K70FUPiQAICFTbeobebeq+dN8w+IA7kkWkMjFMU4X4Vr2TXhYkSQuMthbx4TVMgSW48yh
 H7dCj6WrUt/DdIMY=
X-Received: by 2002:a17:906:142:b0:99b:4378:a5aa with SMTP id
 2-20020a170906014200b0099b4378a5aamr2434009ejh.49.1689955754929; 
 Fri, 21 Jul 2023 09:09:14 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFmarUo/dSbmjvCXACBnzjMRwwzbaB/hWRBZAg5WYqNW5y7ocywqznROM0ro+u0jVfh7CdleQ==
X-Received: by 2002:a17:906:142:b0:99b:4378:a5aa with SMTP id
 2-20020a170906014200b0099b4378a5aamr2433994ejh.49.1689955754620; 
 Fri, 21 Jul 2023 09:09:14 -0700 (PDT)
Received: from ?IPV6:2003:cf:d71a:f311:3075:1f38:7e25:e17a?
 (p200300cfd71af31130751f387e25e17a.dip0.t-ipconnect.de.
 [2003:cf:d71a:f311:3075:1f38:7e25:e17a])
 by smtp.gmail.com with ESMTPSA id
 qt10-20020a170906ecea00b00988e953a586sm2382607ejb.61.2023.07.21.09.09.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jul 2023 09:09:14 -0700 (PDT)
Message-ID: <4109ebd0-ccd7-9e3c-8a32-b4db998d8e39@redhat.com>
Date: Fri, 21 Jul 2023 18:09:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 3/4] vhost: Add high-level state save/load functions
Content-Language: en-US
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-fs@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, German Maglione <gmaglione@redhat.com>
References: <20230712111703.28031-1-hreitz@redhat.com>
 <20230712111703.28031-4-hreitz@redhat.com>
 <CAJaqyWdAjbJxFE7BTzw6zYrr9_80qsxWrvq=kXjKMDTMtYKOKg@mail.gmail.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <CAJaqyWdAjbJxFE7BTzw6zYrr9_80qsxWrvq=kXjKMDTMtYKOKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.094, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 21.07.23 17:18, Eugenio Perez Martin wrote:
> On Wed, Jul 12, 2023 at 1:17 PM Hanna Czenczek <hreitz@redhat.com> wrote:
>> vhost_save_backend_state() and vhost_load_backend_state() can be used by
>> vhost front-ends to easily save and load the back-end's state to/from
>> the migration stream.
>>
>> Because we do not know the full state size ahead of time,
>> vhost_save_backend_state() simply reads the data in 1 MB chunks, and
>> writes each chunk consecutively into the migration stream, prefixed by
>> its length.  EOF is indicated by a 0-length chunk.
>>
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>> ---
>>   include/hw/virtio/vhost.h |  35 +++++++
>>   hw/virtio/vhost.c         | 204 ++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 239 insertions(+)

[...]

>> +int vhost_load_backend_state(struct vhost_dev *dev, QEMUFile *f, Error **errp)
>> +{
>> +    size_t transfer_buf_size = 0;
>> +    void *transfer_buf = NULL;
>> +    g_autoptr(GError) g_err = NULL;
>> +    int pipe_fds[2], read_fd = -1, write_fd = -1, reply_fd = -1;
>> +    int ret;

[...]

>> +    ret = 0;
>> +fail:
>> +    g_free(transfer_buf);
> Nitpick, but transfer_buf could have the g_autofree parameter.

Ah, sure, thanks!

Hanna


