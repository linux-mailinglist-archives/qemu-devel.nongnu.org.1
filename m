Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1992670E493
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 20:24:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1WgS-0004Cd-W6; Tue, 23 May 2023 14:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1WgR-0004C7-9x
 for qemu-devel@nongnu.org; Tue, 23 May 2023 14:24:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1WgP-0003P4-HN
 for qemu-devel@nongnu.org; Tue, 23 May 2023 14:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684866268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cq+cAr4nytrYF4Rr1pVhd6/Nmg6m/Z8DXrgFb9PH448=;
 b=bLmTyx0hLYh/xoJNMnScQHWAlwqyOXfGpBM4/TWTLhe1voFNtvwzJCknOCvIZwKGzC4ouD
 Sfq+a4D0mQ176k22lvkI8OzB61vpkvqUo0AWfm/I2KPJyg84oyp6jd5U1U0hqJl0Za1O/D
 ynL6Y4rcH/73QeGWRHHs4HIxEQ3+/B0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-T_H4C0OEPjePMZJF2e244A-1; Tue, 23 May 2023 14:24:26 -0400
X-MC-Unique: T_H4C0OEPjePMZJF2e244A-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-307897bc279so4980502f8f.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 11:24:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684866265; x=1687458265;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Cq+cAr4nytrYF4Rr1pVhd6/Nmg6m/Z8DXrgFb9PH448=;
 b=UULhVhjkv9BAYuAsHFdN+7Yu3JVaKl/FPtBvYZ3ROm/Tx7omlmj7Do2GNgooGgbYPU
 faa0naPVUKPANFmBzTf+fiAD7ASunI4L0/A95tXoiBLkaW/3d0Je3OmTyS98/BOn9hO3
 AplL/GXWC6fJ+QzbjJhCp6OYhvKxJrSV9BJK2HZjSyDQxZCDEE4HSgW9igvl3hSi2Lvr
 OsLJHyA1ze436qDXBn7MwUL/InZrfRjC+smAV2tKeoEBGqK9CiYZHtXiugIfdo8C+Uwy
 jD/4bVYGbj7wQjzfnRC4T6mQMkku2UMyTwSj3W4mxgsHqD2R5fIEKm8HyLVYi9fVe0XV
 R1RA==
X-Gm-Message-State: AC+VfDxmDRVIz7GevZbLwxCIW24tB9rgLIvhSGJLwPYJAi+CJW40mx9V
 URwF8Ha+eIf5U8U6QCM68ssbTVCAR9fbEomKLqoF6SeSbSE9SRzVC+0YNlTMyOt2yB2kUuZMT8e
 48qwiHl0tbOUcENI=
X-Received: by 2002:adf:e442:0:b0:30a:7446:fd0 with SMTP id
 t2-20020adfe442000000b0030a74460fd0mr7493749wrm.31.1684866265431; 
 Tue, 23 May 2023 11:24:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7HgKzuWbD22xTj7pdbn+5dqQE9bQxPVdkJbahxSZWt4tZlzcTsKaJ3eONtUmlc/9ggbiU/Aw==
X-Received: by 2002:adf:e442:0:b0:30a:7446:fd0 with SMTP id
 t2-20020adfe442000000b0030a74460fd0mr7493736wrm.31.1684866265193; 
 Tue, 23 May 2023 11:24:25 -0700 (PDT)
Received: from [192.168.8.105] (tmo-117-143.customers.d1-online.com.
 [80.187.117.143]) by smtp.gmail.com with ESMTPSA id
 y11-20020adff6cb000000b003063a1cdaf2sm11893967wrp.48.2023.05.23.11.24.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 11:24:24 -0700 (PDT)
Message-ID: <af132528-fe90-5ac1-6a78-fadc06eb8e75@redhat.com>
Date: Tue, 23 May 2023 20:24:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/3] arm/Kconfig: Keep Kconfig default entries in
 default.mak as documentation
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230523180525.29994-1-farosas@suse.de>
 <20230523180525.29994-3-farosas@suse.de>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230523180525.29994-3-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 23/05/2023 20.05, Fabiano Rosas wrote:
> When we moved the arm default CONFIGs into Kconfig and removed them
> from default.mak, we made it harder to identify which CONFIGs are
> selected by default in case users want to disable them.
> 
> Bring back the default entries into default.mak, but keep them
> commented out. This way users can keep their workflows of editing
> default.mak to remove build options without needing to search through
> Kconfig.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   configs/devices/aarch64-softmmu/default.mak |  6 ++++
>   configs/devices/arm-softmmu/default.mak     | 40 +++++++++++++++++++++
>   2 files changed, 46 insertions(+)

Thanks for the update!

Reviewed-by: Thomas Huth <thuth@redhat.com>


