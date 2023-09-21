Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2357A94FB
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 15:58:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjKAj-0006Q3-Si; Thu, 21 Sep 2023 09:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qjKAi-0006PI-4v
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 09:56:48 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qjKAf-0006HS-J6
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 09:56:47 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6c0f4ad9eb1so617513a34.1
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 06:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1695304604; x=1695909404;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aLlclXdwLtN4CPnz5WCduKG/f/78DAzPIWKjXDxK/qc=;
 b=SQU777sXxu5XBRbdpScFpg9MFnfNc/dAHYWOClcDw1jEjH9JxrmLFwUHGYk0CqfJSF
 Zpr974COz796Ai7uXLuLq41DmqBr7cU/SLKmj9OFNL3L/ca+1dlSxplN+du3dmQuSHX5
 S3nATFMka/18Ly1yQ7FQ+9tsWGEk8etWxv5Ns/EPnR1h98J1crQbo+gmbnR5ozwt+yGO
 TExbAyR9Smu4KaMmkbFaaFej8CiIKjubm4wzuZeNZrG7ZgQ6qvstcUI1jcTH1OUD+ei9
 KDjjOtNBmKEXzHbMkYUUT7hx90G7zeq2JEm1JdoQf2QZCsJD3zXUFqT7zVflj+tOWOfk
 UmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695304604; x=1695909404;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aLlclXdwLtN4CPnz5WCduKG/f/78DAzPIWKjXDxK/qc=;
 b=cbxUqg7jOu2SeIKk5kp4kfDE9izfXtVSDfWPxCV0TGvDnU7n/UDHta9O/bH8GwBxN1
 AKu3H4kqP+GIftWOwtTou33XjeijUAtO7/A/cFQkYzorngP+kO8zTmP0vi6y98aE90X2
 ei71hwR0iFy91qCPRqdJ2Vidiwb/8HjE3vKTgQfv1k5v5aKIYOc+5fzH9cGjvTN1t/oS
 ER0nFASe+eQ+VU+aBO7tOJWF5dCxHt8gIIG8DjVGlrNBC152+GviUA6xPwCQd4ijQkND
 gy5PdA+ClDVpv8HS3l5KTWqyTVI15zCseeuWxT8k8dPZSMt0Ho/UVOoZ/nrMatPNvwLd
 jdXg==
X-Gm-Message-State: AOJu0Yz1la/v8FYxqvYvYSHqzhr0eXyo4ID8uAA8lXKNq9HbtD9edUjD
 G4WhB+cKTYTkjoQTyXCpzbqbaw==
X-Google-Smtp-Source: AGHT+IHGzFqlUJGylT0m8qpDaff1kWngIfKdas0mqHoQKHB+wr3DE7CpJH8ubb1Xl46dFid+sA7TnQ==
X-Received: by 2002:a05:6870:4411:b0:1c8:c128:c38e with SMTP id
 u17-20020a056870441100b001c8c128c38emr5947505oah.15.1695304603731; 
 Thu, 21 Sep 2023 06:56:43 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 f9-20020a639c09000000b005781e026905sm1333675pge.56.2023.09.21.06.56.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Sep 2023 06:56:42 -0700 (PDT)
Message-ID: <32d74d08-f6f1-4958-aab7-03144efcbc82@daynix.com>
Date: Thu, 21 Sep 2023 22:56:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/10] virtiofsd: Use qemu_get_runtime_dir()
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, virtio-fs@redhat.com,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Yan Vugenfirer <yan@daynix.com>
References: <20221110100629.61496-1-akihiko.odaki@daynix.com>
 <20221110100629.61496-8-akihiko.odaki@daynix.com>
 <20230921125828.GA3860191@fedora>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230921125828.GA3860191@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::332;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x332.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

On 2023/09/21 21:58, Stefan Hajnoczi wrote:
> On Thu, Nov 10, 2022 at 07:06:26PM +0900, Akihiko Odaki wrote:
>> qemu_get_runtime_dir() is used to construct the path to a lock file.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   tools/virtiofsd/fuse_virtio.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
>> index 9368e292e4..b9eeed85e6 100644
>> --- a/tools/virtiofsd/fuse_virtio.c
>> +++ b/tools/virtiofsd/fuse_virtio.c
>> @@ -901,12 +901,12 @@ static bool fv_socket_lock(struct fuse_session *se)
>>   {
>>       g_autofree gchar *sk_name = NULL;
>>       g_autofree gchar *pidfile = NULL;
>> -    g_autofree gchar *state = NULL;
>> +    g_autofree gchar *run = NULL;
>>       g_autofree gchar *dir = NULL;
>>       Error *local_err = NULL;
>>   
>> -    state = qemu_get_local_state_dir();
>> -    dir = g_build_filename(state, "run", "virtiofsd", NULL);
>> +    run = qemu_get_runtime_dir();
>> +    dir = g_build_filename(run, "virtiofsd", NULL);
>>   
>>       if (g_mkdir_with_parents(dir, S_IRWXU) < 0) {
>>           fuse_log(FUSE_LOG_ERR, "%s: Failed to create directory %s: %s\n",
> 
> tools/virtiofsd/ no longer exists. Which version of QEMU did you develop against?
> 
> commit e0dc2631ec4ac718ebe22ddea0ab25524eb37b0e
> Author: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Date:   Wed Jan 18 12:11:51 2023 +0000
> 
>      virtiofsd: Remove source
> 
> Stefan

It is an old version of the series. You can find the latest version at:
https://patchew.org/QEMU/20230921075425.16738-1-akihiko.odaki@daynix.com/

Regards,
Akihiko Odaki

