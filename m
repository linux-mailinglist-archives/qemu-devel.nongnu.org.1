Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 510EA77B322
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 10:01:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVSUB-0006mk-LJ; Mon, 14 Aug 2023 03:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qVSTu-0006lz-2t
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 03:59:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qVSTs-0001iT-Kh
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 03:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691999954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j6t9KFibenm2vigzkYJ6LK8kiAtL5HjAZ2G+nYUDeAI=;
 b=JZswj569tpNVlMq0jEMU13MXwad83g0XtmKNlfQg9vl13HUSRqL/ny/hsMsl2G0YkMEgl5
 WN+JP46WzuyywOBlcteSEDL6Y4nuynFjWgNwu2hqcFsWbIqY5Tb1vor1BIGj4wEpmjIuSt
 k6Ja4dYqpeqVGjPYCZXpk1BeJdpMg8M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-5SWoxdX9MYGQCGDDYHvpeQ-1; Mon, 14 Aug 2023 03:59:12 -0400
X-MC-Unique: 5SWoxdX9MYGQCGDDYHvpeQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-317d5b38194so1806391f8f.0
 for <qemu-devel@nongnu.org>; Mon, 14 Aug 2023 00:59:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691999951; x=1692604751;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j6t9KFibenm2vigzkYJ6LK8kiAtL5HjAZ2G+nYUDeAI=;
 b=hqzIKwL+AD6K7WlYmPz61vlt8PruVaNVgBCecKKElZkj6qxRkilGJeMf6KXZOc4TsO
 FKbl+42w8H3/hgBxKafTa84xcEIDtByg7D9RcTxl1pC/UaUqjrdw3NusTow7PtrD8fqW
 M1CzWEMM5V7uYVfa+jRC/NhVfvYtO95gY0ob0QlIYle6Foq4DZhDvtB2A5jiUiEvn5O1
 jstHO22MGX4U9lbYkC5OgOKW1Z2zs6VqSchKn983JA0wZw9hJ/qy/5Nxpj4kInQSuvdT
 fcs+gSQuGuDmXmkv7oEoFTzigkr+tF+MsiMQ2mWrt7zuQ0/VRAbnljdo86bukjiQyRGf
 nvTQ==
X-Gm-Message-State: AOJu0Yxe8Y9k6uMy+VxdJ+FLThccpZ38IAClTBsw0JWy/ejTORYgsBev
 nj5I/x2R16mYNPmQH3L4lHsOSMinshDO0FF44XWND9CxeLz5PbNOn8N35H+rQN6A3/E+o6VpujW
 BFGQR/VmKiFojOG4=
X-Received: by 2002:adf:e80a:0:b0:319:789f:fcda with SMTP id
 o10-20020adfe80a000000b00319789ffcdamr1217195wrm.9.1691999951516; 
 Mon, 14 Aug 2023 00:59:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHL5kAUBXOKjJ3PWtCdENoodLbwx+IBaszJbbxfY6DMvxefc6A/5kjd3sw+yJ1BXogLyLcn0Q==
X-Received: by 2002:adf:e80a:0:b0:319:789f:fcda with SMTP id
 o10-20020adfe80a000000b00319789ffcdamr1217185wrm.9.1691999951233; 
 Mon, 14 Aug 2023 00:59:11 -0700 (PDT)
Received: from [192.168.8.105]
 (dynamic-046-114-244-033.46.114.pool.telefonica.de. [46.114.244.33])
 by smtp.gmail.com with ESMTPSA id
 y14-20020adff6ce000000b00317e9f8f194sm13619021wrp.34.2023.08.14.00.59.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Aug 2023 00:59:10 -0700 (PDT)
Message-ID: <2b541550-162f-cd97-1836-72cf64951415@redhat.com>
Date: Mon, 14 Aug 2023 09:59:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/8] tests/docker: cleanup non-verbose output
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Yonggang Luo
 <luoyonggang@gmail.com>, Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>
References: <20230810153640.1879717-1-alex.bennee@linaro.org>
 <20230810153640.1879717-3-alex.bennee@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230810153640.1879717-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -64
X-Spam_score: -6.5
X-Spam_bar: ------
X-Spam_report: (-6.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.359, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/08/2023 17.36, Alex Bennée wrote:
> Even with --quiet docker will spam the sha256 to the console. Avoid
> this by redirecting stdout. While we are at it fix the name we echo
> which was broken during 0b1a649047 (tests/docker: use direct RUNC call
> to build containers).
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/docker/Makefile.include | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index 142e8605ee..dfabafab92 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -46,9 +46,9 @@ docker-image-%: $(DOCKER_FILES_DIR)/%.docker
>   		--build-arg BUILDKIT_INLINE_CACHE=1 	\
>   		$(if $(NOUSER),,			\
>   			--build-arg USER=$(USER)	\
> -			--build-arg UID=$(UID))	\
> -		-t qemu/$* - < $<, 			\
> -		"BUILD", $1)
> +			--build-arg UID=$(UID))		\
> +		-t qemu/$* - < $< $(if $V,,> /dev/null),\
> +		"BUILD", $*)

Reviewed-by: Thomas Huth <thuth@redhat.com>


