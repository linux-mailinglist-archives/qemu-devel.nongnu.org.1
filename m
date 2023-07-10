Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A4474CF8B
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 10:11:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIlzC-00017H-GP; Mon, 10 Jul 2023 04:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIlz9-00016s-Ai
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 04:11:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIlz6-0008DZ-2N
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 04:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688976663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=00U4RgzMbJAuVoefdJtwQj8KIV+sfHK8YNhRD99iVqI=;
 b=PS/E3wsXt+cDzBHPPuAicvBUf/9Spnhs6i3s0TFJ+dedrFlKaIeyy2pao6VhdKr3EXCp9K
 xySgNUYKOawitGfcAFQOsU1OJ2vU/0W5MxXP5ynJ+rYjp7YrPlZvsu6wL1OQinr01algCI
 AGDejIDnpf4QU8WGCfl+8w8yIsG0siQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-OjgJb6rxMQyaFSgn2_xTaw-1; Mon, 10 Jul 2023 04:11:02 -0400
X-MC-Unique: OjgJb6rxMQyaFSgn2_xTaw-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7659c6caeaeso561352185a.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 01:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688976662; x=1691568662;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=00U4RgzMbJAuVoefdJtwQj8KIV+sfHK8YNhRD99iVqI=;
 b=JCnr+eCqZFkrCr8cIgdH74nh+o522P2f+Lh3971qW36MtxsTG8pjegwuLLsEhmhH/E
 Harr3d5P6pnsmH9dn8i9tmnWgGjRHP1Vcj8I9N+JYrvxndGvsLw4XawxT9L4g8zFxI95
 HW8mUUUqLK6+wyHRBUokFfXL/PjBoxSlSZIspfP8Kia0rB2400P2sjBSWgxBX3OycZ3Y
 YlxfmCQLS3ljgyQAsnk4EhBf4e+1Yt32vlsxekh9nVYSoU00RF++bSflBAswlaILYWlj
 kg1kcW+s5bO4CA8l9/W6Ys99zFWkEaLr+XPWc5efylaLJ8xXTS+Z+qzIvggWfui4awB3
 fvvA==
X-Gm-Message-State: ABy/qLbet0iSR/WRtacoM4GCJsQqX11OmSG+PAJJ79D2Ob+mz4O8hspn
 rYcaSBEW4tbfev6HwdZH6WU4vEJcT8EOUBheunuH3Q1c1rpfmLnCBGLX2B10YUUgXZzuzIwXa2j
 fZAh26HgaHvpOWkY=
X-Received: by 2002:a05:620a:198f:b0:767:b870:ca9f with SMTP id
 bm15-20020a05620a198f00b00767b870ca9fmr8236115qkb.31.1688976661943; 
 Mon, 10 Jul 2023 01:11:01 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEPha8W6wzyu5703r0I998WlmDQNzM0g8ToXN9FiQ/ptemIbR89MN+OOvI8uggr3oUrw3Mw7A==
X-Received: by 2002:a05:620a:198f:b0:767:b870:ca9f with SMTP id
 bm15-20020a05620a198f00b00767b870ca9fmr8236099qkb.31.1688976661662; 
 Mon, 10 Jul 2023 01:11:01 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-179-116.web.vodafone.de.
 [109.43.179.116]) by smtp.gmail.com with ESMTPSA id
 v15-20020ae9e30f000000b00767b0c35c15sm3627872qkf.91.2023.07.10.01.11.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 01:11:01 -0700 (PDT)
Message-ID: <5dddf780-5758-2e30-41f7-0de86b9de89a@redhat.com>
Date: Mon, 10 Jul 2023 10:10:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 4/4] QGA VSS: Add log in functions begin/end
Content-Language: en-US
To: Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230710074639.996030-1-kkostiuk@redhat.com>
 <20230710074639.996030-5-kkostiuk@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230710074639.996030-5-kkostiuk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 10/07/2023 09.46, Konstantin Kostiuk wrote:
> Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
> ---
>   qga/vss-win32/install.cpp   | 33 +++++++++++++++++++++++++++++++++
>   qga/vss-win32/provider.cpp  |  3 +++
>   qga/vss-win32/requester.cpp | 34 ++++++++++++++++++++++++++++++++++
>   3 files changed, 70 insertions(+)
> 
> diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
> index 9bd2c52b70..6865c04d8a 100644
> --- a/qga/vss-win32/install.cpp
> +++ b/qga/vss-win32/install.cpp
...
> @@ -175,6 +181,8 @@ out:
>   static HRESULT QGAProviderFind(
>       HRESULT (*found)(ICatalogCollection *, int, void *), void *arg)
>   {
> +    qga_debug_begin;
> +
>       HRESULT hr;
>       COMInitializer initializer;
>       COMPointer<IUnknown> pUnknown;
> @@ -205,12 +213,15 @@ static HRESULT QGAProviderFind(
>       chk(pColl->SaveChanges(&n));
>   
>   out:
> +    qga_debug_end;
>       return hr;
>   }
>   
>   /* Count QGA VSS provider in COM+ Application Catalog */
>   static HRESULT QGAProviderCount(ICatalogCollection *coll, int i, void *arg)
>   {
> +    qga_debug_begin;
> +
>       (*(int *)arg)++;
>       return S_OK;
>   }

Missing gqa_debug_end here?

...
> @@ -277,6 +298,8 @@ VSS_BACKUP_TYPE get_vss_backup_type(
>   
>   void requester_freeze(int *num_vols, void *mountpoints, ErrorSet *errset)
>   {
> +    qga_debug_begin;
> +
>       COMPointer<IVssAsync> pAsync;
>       HANDLE volume;
>       HRESULT hr;
> @@ -292,6 +315,7 @@ void requester_freeze(int *num_vols, void *mountpoints, ErrorSet *errset)
>   
>       if (vss_ctx.pVssbc) { /* already frozen */
>           *num_vols = 0;
> +        qga_debug("finished, already frozen");
>           return;
>       }
>   
> @@ -449,6 +473,7 @@ void requester_freeze(int *num_vols, void *mountpoints, ErrorSet *errset)
>           }
>       }
>   
> +    qga_debug("preparing for backup");
>       hr = vss_ctx.pVssbc->PrepareForBackup(pAsync.replace());
>       if (SUCCEEDED(hr)) {
>           hr = WaitForAsync(pAsync);
> @@ -472,6 +497,7 @@ void requester_freeze(int *num_vols, void *mountpoints, ErrorSet *errset)
>        * CQGAVssProvider::CommitSnapshots will kick vss_ctx.hEventFrozen
>        * after the applications and filesystems are frozen.
>        */
> +    qga_debug("do snapshot set");
>       hr = vss_ctx.pVssbc->DoSnapshotSet(&vss_ctx.pAsyncSnapshot);
>       if (FAILED(hr)) {
>           err_set(errset, hr, "failed to do snapshot set");

You should maybe mention these qga_debug() statements in the commit description.

  Thomas


