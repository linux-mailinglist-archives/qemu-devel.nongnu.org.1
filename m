Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C21739A91
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 10:49:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCFya-0005uS-7X; Thu, 22 Jun 2023 04:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qCFyY-0005uH-G6
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 04:47:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qCFyX-0002K1-3C
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 04:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687423652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dxs1mg2OSy9cAbwBphpRWdrD51K4lGMPvJZXbeuUMsA=;
 b=Z+Aci90vkHdB0i8QXpmd6Esu3NkpjdeCoHu5dThuc/0UxZ8+7y56bTOgT23vnBjcj+a8+U
 H6kAgOHqno+qUAQ3CE5dF5XR8BcJ7XUohlBrLejiu+0+ZiwgXNqPYVCmxOAMeHYID+FhBi
 N57lQZU87VL76WsAUfT8CE741Pd0zw4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-AC3Fyo4KM3mOQHCVqEQo4g-1; Thu, 22 Jun 2023 04:47:30 -0400
X-MC-Unique: AC3Fyo4KM3mOQHCVqEQo4g-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fa72092f95so2266475e9.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 01:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687423649; x=1690015649;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dxs1mg2OSy9cAbwBphpRWdrD51K4lGMPvJZXbeuUMsA=;
 b=knI9Yv+mmvEUI8r07jNLaMUUyRoFmt+vMnxEfiQv55Ch3Hbc2EpAviWXHkgxrODot7
 156mhh9gvnJotKfe9rrJBZtOWRVHDa1tGrHcokcT0R36NQKFw+PZuP0gLIUJWGnj06qy
 K6OFw/MBZtMlzAaBm0k1rm1oA/WpMjTcCEi3fhEZ0dZk5q46cMyuG9yCaAESk5BrnNnJ
 pvL/gbbRYiugrIFHd4WHY8m8zL0eFo0NCMgfrBpwGabKb+A2I5ldHoBb091KiDDDlFJx
 Puxo9/GMqNnyhtJFN8U6k+GYhMZPDtRaTjVktAWRq1V2HpD5jUPC8RfmTpBuJF80LBzx
 zDAg==
X-Gm-Message-State: AC+VfDxwPonfhc+oiRWv92mp1pbQ2e2vkRQrKWJFBbhn843P0fkbWai9
 7WY7Z7x84ElFUX78RPv7j/uhm7dfHLXpyNcw0pWI8p0annbaJe7X9mzPaeE6sknjDQgr8LobzNs
 ugS2hXuwmIlSPYUU=
X-Received: by 2002:a05:600c:21d8:b0:3f9:bc32:ca6c with SMTP id
 x24-20020a05600c21d800b003f9bc32ca6cmr4532291wmj.13.1687423649502; 
 Thu, 22 Jun 2023 01:47:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ67E/5g6oArNvDjxr8tTux9folnM+y6l9zIVFaw7aoP2IKZq/GmxIgyQWPwKk8PwIwm3VASNg==
X-Received: by 2002:a05:600c:21d8:b0:3f9:bc32:ca6c with SMTP id
 x24-20020a05600c21d800b003f9bc32ca6cmr4532274wmj.13.1687423649243; 
 Thu, 22 Jun 2023 01:47:29 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 n12-20020a7bc5cc000000b003eddc6aa5fasm18205410wmk.39.2023.06.22.01.47.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jun 2023 01:47:28 -0700 (PDT)
Message-ID: <77db236c-6cfc-a8e2-50a3-30a6d5565bf7@redhat.com>
Date: Thu, 22 Jun 2023 10:47:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 0/2] gitlab-ci: msys2 improvements
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
References: <20230620153720.514882-1-marcandre.lureau@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230620153720.514882-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

On 20/06/2023 17.37, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Hi,
> 
> Submitting again this small series from last year.
> 
> Marc-André Lureau (2):
>    gitlab-ci: grab msys2 meson-logs as artifacts
>    gitlab-ci: add msys2 meson test to junit report
> 
>   .gitlab-ci.d/windows.yml | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)

Thanks, queued the patches for my next pull request.

  Thomas


