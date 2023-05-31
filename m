Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE525717D2E
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 12:23:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Iyn-0004h1-83; Wed, 31 May 2023 06:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4Iyh-0004gV-DJ
 for qemu-devel@nongnu.org; Wed, 31 May 2023 06:22:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4Iyf-0001Y4-RX
 for qemu-devel@nongnu.org; Wed, 31 May 2023 06:22:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685528569;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=wF4jJo8/36J/PvaypR9reMAnpMIGxkD0QdtdLPap6E0=;
 b=imU12lKE0CCixjfggDbnhd0PY8BZdMBsiAyQz6boU3udBBu23XMFClyslHHqIKvXFbRWQu
 XTX5MdJRlMy0c3Y1FpV2jWPCoq9w4maN8GwMvVnXiqlhFA0efNHiTXNTCTmN2tR2ZllMCK
 GOhEYeAuKA0MkGIT4ObO90a6GhVImCw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-kmRHXb6SMZKgJTsug97Ekg-1; Wed, 31 May 2023 06:22:45 -0400
X-MC-Unique: kmRHXb6SMZKgJTsug97Ekg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3079c6648e3so3400132f8f.2
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 03:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685528564; x=1688120564;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wF4jJo8/36J/PvaypR9reMAnpMIGxkD0QdtdLPap6E0=;
 b=koNbNDjTpI7fPdYxcP0hZUOYFnPIVCwepkF8QljX/ekHU1TgC/y1hiPq4LC15gse4k
 lAWbrDNusDikvAlvCsq0Nms7fCghFIw8nJTiiW/Sje3LaLmfOuUJHCePqVSFyYyBTP/P
 fW9NRIDQhdeIWrVsjQuVStrsHynxAJBlT+WkAa95JlV8l13+wK08AR1tEt8cLc7sqyk6
 /BXg/xf6/rNgdRIeCLzlpKb5u8Qdhf66ffxEqqKziZPpo3k5Dt7YSSWlSgRhck+Wb29N
 gei9N3uZt2N4z5k0NXa+GJiCp1ivZtOA74EU4Y/AThCW6pRdBoHH7OOZZgeMMDRvAhgO
 NYnw==
X-Gm-Message-State: AC+VfDy10MuOkA3s+aTAv2CF21V1M0nuLG978AXz1o319fPlBud8s/eH
 sd3mt6btd4gKuJzdhCCRFxUMOCpc+uJN6wvzLowyruMpNlNGCbsuWWulcfdLuGQsdME8F+1Gyeb
 WFjheGNf73au5Ny8=
X-Received: by 2002:adf:f050:0:b0:30a:c625:8028 with SMTP id
 t16-20020adff050000000b0030ac6258028mr3829562wro.35.1685528564717; 
 Wed, 31 May 2023 03:22:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7xDjeJI4hobO2OqYhrHMnphCn49giquaPz+1wa5BJE4JvbP7ZEdt7FqZaloaegzFKJm99wWA==
X-Received: by 2002:adf:f050:0:b0:30a:c625:8028 with SMTP id
 t16-20020adff050000000b0030ac6258028mr3829539wro.35.1685528564295; 
 Wed, 31 May 2023 03:22:44 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 b7-20020a5d4d87000000b0030af8da022dsm3363624wru.44.2023.05.31.03.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 May 2023 03:22:43 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org,  Leonardo Bras <leobras@redhat.com>,  Hailiang
 Zhang <zhanghailiang@xfusion.com>,  Peter Xu <peterx@redhat.com>,  Stefan
 Hajnoczi <stefanha@redhat.com>,  qemu-block@nongnu.org,  Fam Zheng
 <fam@euphon.net>
Subject: Re: [PATCH v2 00/20] Next round of migration atomic counters
In-Reply-To: <7acf22e1-6687-a633-2639-bae88f516354@proxmox.com> (Fiona Ebner's
 message of "Wed, 31 May 2023 11:10:04 +0200")
References: <20230530183941.7223-1-quintela@redhat.com>
 <7acf22e1-6687-a633-2639-bae88f516354@proxmox.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Wed, 31 May 2023 12:22:42 +0200
Message-ID: <87zg5ku7f1.fsf@secure.mitica>
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

Fiona Ebner <f.ebner@proxmox.com> wrote:
> Am 30.05.23 um 20:39 schrieb Juan Quintela:
>> Hi
>> 
>> On this v2:
>> 
>> - dropped qemu_fflush() assert for read only files (make Richard
>>   happy)
>> 
>> - Update documentation for qemu_file_transferred (make Fabiano happy)
>> 
>> - migration/rdma: Remove qemu_fopen_rdma() and make it look like
>>   everything else
>> 
>> - Simplify a couple of qemu-file functions, and unexport the ones that
>>   are not used outside of qemu-file.c
>> 
>> - Added Reviewed-by comments.
>> 
>> Please review.
>> 
> Hi,
> I don't notice any performance regression with snapshots anymore with
> this series :)
>
> Note that I had to apply your PULL patches from yesterday too, to be
> able to apply this series:
> https://lists.nongnu.org/archive/html/qemu-devel/2023-05/msg07361.html

I know, thanks.

Later, Juan.


