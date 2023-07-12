Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8A0750EBA
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 18:39:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJcr9-0002hP-MB; Wed, 12 Jul 2023 12:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qJcr7-0002gv-KZ
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 12:38:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qJcr5-0004Pk-OP
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 12:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689179898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lICL8+3kj1DVjaaJZ3TfPqI82BUScpk7OfZrv40Cpmo=;
 b=CA8uFScEpZbHp5W5aMjPEvl1jSR88i4a8gCbJDZST19N0UkZdJjSQRJVXlMbV19Vt6o4he
 91uvwMVRJf97pzoE0t4paYUgIY5AdCN3RpdM1lddRxWsf0v63D1ANznXOq2JEpSVJV6hhC
 fMUG7TfX8FKWgizigvtViWOJPqr7gkA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-O86_5LU3Ny-9rjoOPTlIQQ-1; Wed, 12 Jul 2023 12:38:17 -0400
X-MC-Unique: O86_5LU3Ny-9rjoOPTlIQQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-51e2497eeefso4589944a12.3
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 09:38:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689179896; x=1691771896;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lICL8+3kj1DVjaaJZ3TfPqI82BUScpk7OfZrv40Cpmo=;
 b=CNA5dquVyT2tNLMbiJfrXEJ/zf4Ro8fKuNmcaEue7bnMaoPPLhhpDysKItmgnXEKUd
 uNw0yKORghtmXMMmkmTBjMHuX1+W3EoWegzZeK8/S2v3sh03WFguB59TWAhkVcAFtOLg
 R5JOhOfN/FlGRnNhnyTZB9GLPWzRFSppPGS/SxzIyDIHUIJsmFyjT7cHMgfNW1bgFqXb
 lvvcQiTwFapHEcxRIkSSZ8AUr5yc4IjfKobacdIHvlZKVk7CHrj9/HLX3pCXxBY/m9/j
 p9nv1/FyH0haN1WzNwqbMsuPhERbSEGCUKeqEj4oGxZ9RJydVzS8A6KoC1TG6KazzgRu
 NnCQ==
X-Gm-Message-State: ABy/qLYCYCv4D+b4cDmY1OU0u51k2Yfbm+7f5ioj72j6/qIeBexQv/GY
 4F8CSnQpSOhhVCQFGroCYZw/JVgaOt4CfhgEq/ouRFd4WARpdt2AxZzwekb2s2XlbjCo7o9CyPu
 zm8iG43xVs04AoNc=
X-Received: by 2002:aa7:d052:0:b0:51d:a02d:f8fe with SMTP id
 n18-20020aa7d052000000b0051da02df8femr15825462edo.29.1689179896145; 
 Wed, 12 Jul 2023 09:38:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFw4g6yFUIe3dsEcITItugUp53vcEGer9oqlZF4qnjhbx50XO0/wkNWcWnTS0ThOYBqUIMF+A==
X-Received: by 2002:aa7:d052:0:b0:51d:a02d:f8fe with SMTP id
 n18-20020aa7d052000000b0051da02df8femr15825445edo.29.1689179895817; 
 Wed, 12 Jul 2023 09:38:15 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c?
 ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.googlemail.com with ESMTPSA id
 dy23-20020a05640231f700b0051e22d3f328sm2956044edb.96.2023.07.12.09.38.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jul 2023 09:38:15 -0700 (PDT)
Message-ID: <602625fe-f971-8843-88b6-a63dbe52befe@redhat.com>
Date: Wed, 12 Jul 2023 18:38:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] scsi: fetch unit attention when creating the request
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Cc: Mike Christie <michael.christie@oracle.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Mark Kanda <mark.kanda@oracle.com>, Fam Zheng <fam@euphon.net>
References: <20230712134352.118655-1-sgarzare@redhat.com>
 <20230712134352.118655-2-sgarzare@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230712134352.118655-2-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.11, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 7/12/23 15:43, Stefano Garzarella wrote:
> Commit 1880ad4f4e ("virtio-scsi: Batched prepare for cmd reqs") split
> calls to scsi_req_new() and scsi_req_enqueue() in the virtio-scsi device.
> This had no drawback, until commit 8cc5583abe ("virtio-scsi: Send

More precisely, it was pretty hard to trigger it; it might be possible 
using a CD-ROM, as it can report a MEDIUM_CHANGED unit attention.  I 
will change "This had no drawback" to "No ill effect was reported"

> "REPORTED LUNS CHANGED" sense data upon disk hotplug events") added a
> bus unit attention.

... that was fairly easy to trigger via SCSI device hotplug/hot-unplug.

Queued the series, thanks for the tests and for applying the cleanups on 
top.

> Co-developed-by: Paolo Bonzini <pbonzini@redhat.com>

Heh, I basically only wrote the "if (req->init_req)" statement so that's 
pretty generous, but I'll keep it anyway. :)

Paolo

> Having the two calls separated, all requests in the batch were prepared
> calling scsi_req_new() to report a sense.
> Then only the first one submitted calling scsi_req_enqueue() reported the
> right sense and reset it to NO_SENSE.
> The others reported NO_SENSE, causing SCSI errors in Linux.


