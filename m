Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B39527497B0
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 10:51:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHKgS-0001hS-Dr; Thu, 06 Jul 2023 04:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qHKgL-0001gJ-PH
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 04:49:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qHKgK-0007R0-3k
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 04:49:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688633382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qyZ8GpdrNZGRhIXLWUDfliNUZE38nlTnizftmOInMNU=;
 b=OhtDC0A0rfRJWqV0UqlbVVZBuVyyTdISSNBGtykDtVxVOhMBeGGN46yM0O/61pqbTg84rU
 3HqoC2Gx2NAYI8LyvScMwm4XZpUjHnI/L0QSQp9OypF5LICOVfGir+uAY7TQWl/E8nPLmM
 EgnNRUxXX9mK1g503EyHZVwhVqEHcP8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-0P2CGFgONaaEBvQsDD2HoA-1; Thu, 06 Jul 2023 04:49:41 -0400
X-MC-Unique: 0P2CGFgONaaEBvQsDD2HoA-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4033a6deb00so3637791cf.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 01:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688633381; x=1691225381;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qyZ8GpdrNZGRhIXLWUDfliNUZE38nlTnizftmOInMNU=;
 b=SVxNXTT4ww8yRykrodCVG49ZRC6Xsa0+//tKLRSY/SdiL4sC2caJE5PKaZQRqL/K6h
 Jw3D+MK5vqjq93noPfF/zXauC7wQB/wyr10QCL0rZmkxlGMM1zTPYCzBQnKtbBf1IgWv
 DIsrd2D5dRTgbI/7a4I01b2Dy7Uk2OV5swuLH2kpWxjQJCdrYDjXA28yhCaJr79tZQ8a
 JsRIzBwzRlIf9UQ2Ub9FrUF2Almxteh7HnUmzcevWmnZxth57C2SyD0Iw+quSwii+SET
 oTOo7mS43tMn6HndjjwT3ShYKZpxXtIDbb+tsdtJ6D8e1EWjITMM0oaTkCb7ZXN3OQMB
 yMCw==
X-Gm-Message-State: ABy/qLatgiVoWB7mkv77myJjtp0CnIa/2dvgwpQ4eYpgNcPWIRH8G7ih
 dAQ3ZDKxFuRAqeMazZOpjK+l56KecxPDvT6ac8ZBfTLQ4NKKmPxNtDXdjN1KSCvMdskEUGWdqKC
 +3H+YqWDrVQc+kOo=
X-Received: by 2002:a05:622a:487:b0:400:8613:5379 with SMTP id
 p7-20020a05622a048700b0040086135379mr5019584qtx.8.1688633381157; 
 Thu, 06 Jul 2023 01:49:41 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEWmLwd2pzbRhIFUfwjJ1EM9cbHlP4+9I540VjR9BmxYyQTYHsOeBCm1ZQyWypuJXJjudbd/w==
X-Received: by 2002:a05:622a:487:b0:400:8613:5379 with SMTP id
 p7-20020a05622a048700b0040086135379mr5019578qtx.8.1688633380936; 
 Thu, 06 Jul 2023 01:49:40 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-114.web.vodafone.de.
 [109.43.176.114]) by smtp.gmail.com with ESMTPSA id
 s2-20020ac85ec2000000b003ff654694b6sm396257qtx.46.2023.07.06.01.49.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jul 2023 01:49:40 -0700 (PDT)
Message-ID: <46c80c90-76dc-fc35-a383-7fbe7e43d66b@redhat.com>
Date: Thu, 6 Jul 2023 10:49:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/5] migration: migrate 'blk' command option is
 deprecated.
Content-Language: en-US
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 libvir-list@redhat.com, Peter Xu <peterx@redhat.com>, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>, Fam Zheng <fam@euphon.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
References: <20230622195019.4396-1-quintela@redhat.com>
 <20230622195019.4396-4-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230622195019.4396-4-quintela@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 22/06/2023 21.50, Juan Quintela wrote:
> Set the 'block' migration capability to 'true' instead.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>   docs/about/deprecated.rst |  7 +++++++
>   qapi/migration.json       | 10 +++++++---
>   migration/migration.c     |  5 +++++
>   3 files changed, 19 insertions(+), 3 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


