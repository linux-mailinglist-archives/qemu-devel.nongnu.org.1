Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BFB716240
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:39:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zYF-0003IX-8T; Tue, 30 May 2023 09:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3zYD-0003BZ-7e
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:38:13 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3zYB-0005bA-DL
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:38:12 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3f6d01d390bso46661615e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 06:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685453890; x=1688045890;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0TIvREcJQjRw3FtDlTnTg3R1cumfzKc6yJ+R9pjXbe8=;
 b=b84iLtyoqAnPJ05UX50tPL5DY2zTDqecKIuEyZISqqn38YDmE3qBbwG6Ye9DhsgQeN
 eXIgvUro2ZMV76yA+T6KVEzK1iwQZ8Ri+nFVYaxBzFq1GiCEp70+8I3WTprw17jKHOeb
 FLu8rGn/7eHIzN8oWxA+wRi/VPlLuB0Qj33GWG/Yb6e9DBq1kq3s4kgLzIJt+5QvrtJv
 PcdBfOs0EUL7nUxMrZ95WYT6Biz7y6qlaZj5DvJP4kqxpV3p+i1QQiAxQ8OYZN5B27+S
 GVEbItOVgMjbR0/jLMEx+PPu5HWc/qFJAXP0RIdJv8g+plA7xP0d3zvUVznvOOx6iYR4
 uy9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685453890; x=1688045890;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0TIvREcJQjRw3FtDlTnTg3R1cumfzKc6yJ+R9pjXbe8=;
 b=AmN8uNgcjkI5E2dRA04d/W/T8nTilMjILcZIpD/csWhN0qRgJ8cvvfcG7Bi+RHW4v3
 mGL2X9AtRkPHRAUsarIrUknkr+5vGkSgNGUvmPfWyTgYDQl19TyNdG46qjXv013W3E/6
 Njti+cbSCtPKAS8oNIhQhTCcVf1QggLrSSDXSJht5fxVE/K8BePSBfkaSEGo3heY1E2d
 i/eSJd4TiNfitarIeA41abBIN/uF8TIjIvE0+7X676FnCj6LaKfaoBC5hdxO8UKMI7Uf
 OqRzt7N3NGNydUdohT3Uy2Z2rriIUnLm5m7phZZj7pnB/RElvUCY8u7bpV1WRP+ERK8v
 8UnA==
X-Gm-Message-State: AC+VfDzAKpg8vAXSN6sGGJSEeHH1J5qGzu7316DBdV6NRscotkLG5Lis
 bf27uQgi+FBBFnhwqCF4iMsDlw==
X-Google-Smtp-Source: ACHHUZ7SSvb2V7Kd3xxWO6Ft7DobFyvpA+XnzEM1s0gFQLxoZHm978u1xvLZtZ5RJqNceQf9lHvsDQ==
X-Received: by 2002:a7b:c44a:0:b0:3f4:2c71:b9ad with SMTP id
 l10-20020a7bc44a000000b003f42c71b9admr2187866wmi.30.1685453889860; 
 Tue, 30 May 2023 06:38:09 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.180.1])
 by smtp.gmail.com with ESMTPSA id
 k25-20020a05600c1c9900b003f1738d0d13sm33661630wms.1.2023.05.30.06.38.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 06:38:09 -0700 (PDT)
Message-ID: <bd4c064c-39f9-cde2-d392-dff01c404080@linaro.org>
Date: Tue, 30 May 2023 15:38:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH V9 00/46] Live Update
Content-Language: en-US
To: Steven Sistare <steven.sistare@oracle.com>
References: <1658851843-236870-1-git-send-email-steven.sistare@oracle.com>
 <53075574-9e73-f773-ccb1-cca42a719801@oracle.com>
 <d0a2df99-5935-9b06-cc42-fd93488b59f5@oracle.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Jason Zeng <jason.zeng@linux.intel.com>, Zheng Chuan
 <zhengchuan@huawei.com>, Mark Kanda <mark.kanda@oracle.com>,
 Guoyi Tu <tugy@chinatelecom.cn>, Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, David Hildenbrand <david@redhat.com>,
 John Snow <jsnow@redhat.com>, Peng Liang <tcx4c70@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <d0a2df99-5935-9b06-cc42-fd93488b59f5@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Steve,

On 7/2/23 19:44, Steven Sistare wrote:
> To make forward progress on this series and reduce its size, I will be posting
> those of its patches that can be independently integrated and have some value
> on their own, to a reduced distribution of reviewers for each.  This is what
> I plan to break out:
> 
> migration: fix populate_vfio_info
> 
> memory: RAM_NAMED_FILE flag
> 
> memory: flat section iterator
> 
> oslib: qemu_clear_cloexec
> 
> migration: simplify blockers
> 
> migration: simplify notifiers
> 
> python/machine: QEMUMachine full_args
> 
> python/machine: QEMUMachine reopen_qmp_connection
> 
> qapi: strList_from_string
> qapi: QAPI_LIST_LENGTH
> qapi: strv_from_strList
> qapi: strList unit tests

The break out looks good, but I guess it is a bit obsolete (as of
today), you probably already re-posted some of these patches as
separate series. Do you mind replying with a "ping" to the posted
ones which still applies and need to be reviewed?

Thanks,

Phil.

> - Steve
> 
> On 12/7/2022 10:48 AM, Steven Sistare wrote:
>> This series desperately needs review in its intersection with live migration.
>> The code in other areas has been reviewed and revised multiple times -- thank you!


