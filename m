Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B967BB5FC
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:10:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoijF-0004bb-LA; Fri, 06 Oct 2023 07:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qoij3-0004Ws-TF
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:10:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qoij1-0007vj-5w
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:10:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696590630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L8YIUa85CNzgTidlzmc4oUaFxR6U/91xHhGBIeJDwXM=;
 b=Hgfj49rTzD6k5S+XFiMq1I4rq5gVgKFdQwO6IAUZJVXfeEIDqdqMvebyk01+lqKbHqCuLq
 t9TFaDBB5J45jQweIhuSsNcWbkS/RUv4GMNr8FSP81v133CvIudLpiiz0EbTiQ/8xs7Skb
 igaayFWjsTH5qFTYVcHZSyih7S4BBhg=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-RAv9_fdpNOqsCo8z_YHjnA-1; Fri, 06 Oct 2023 07:10:29 -0400
X-MC-Unique: RAv9_fdpNOqsCo8z_YHjnA-1
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-7a2c27d8d70so121412439f.2
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 04:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696590628; x=1697195428;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L8YIUa85CNzgTidlzmc4oUaFxR6U/91xHhGBIeJDwXM=;
 b=LY5berAe1ZKxJvAnFkw7ZTzuCY2dDJQvGbXUmO8VsD3exahMglMMCoJbtbAVzTod5r
 BTVMlgxPn2SLVcmaquGjRAelP9fAyrjSubz3CiOkAttOAxsB6BtYHyVc88gzo59RKyFE
 WPkIAgPOF0HG6vice7vzexw1tCJXePudHe0aaMXFXsBIigyA+RunIwRsEJw05KXgZPu7
 9jB6tzXcBaj7RXf/I/jkxVLeNDO287HK/9fnACFj6X9fN6ANzhVgNTnQGzLGcVKd4Pbo
 RcpxadIF066ycfYHnQ95WRI/sjecft7yqM+u40DEMOU2LqqcJBwLAjl4fil7o9KBsIGL
 57jw==
X-Gm-Message-State: AOJu0Ywts1YE9BYdl+eJ4uar3crD7sDMe3299CBfykqDpCW5rYO0MdsG
 +tHOHKs+yPVhquEDGNxn/U0PryR56EPrUa9lAFSF8/hHTL0ZM7K6ZI97ETX+4THF+Z2dB95rBIi
 K8p80pBuXCqWy1AI=
X-Received: by 2002:a6b:e819:0:b0:79f:cc7f:396f with SMTP id
 f25-20020a6be819000000b0079fcc7f396fmr8471988ioh.1.1696590628385; 
 Fri, 06 Oct 2023 04:10:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsZ7+XPMQ6UlwhiIufP8puGpKdmkhpZqa2eithRL6yVixhdrSfgMYzb1jIDpVB8Yrl6MZWgw==
X-Received: by 2002:a6b:e819:0:b0:79f:cc7f:396f with SMTP id
 f25-20020a6be819000000b0079fcc7f396fmr8471971ioh.1.1696590628080; 
 Fri, 06 Oct 2023 04:10:28 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-27.web.vodafone.de.
 [109.43.176.27]) by smtp.gmail.com with ESMTPSA id
 q6-20020a056638040600b0042b4f9ddecasm340129jap.85.2023.10.06.04.10.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Oct 2023 04:10:27 -0700 (PDT)
Message-ID: <7156d603-ec8f-002f-33d9-36f262b09057@redhat.com>
Date: Fri, 6 Oct 2023 13:10:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 03/16] net/net: Clean up global variable shadowing
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Jason Wang <jasowang@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>
References: <20231004120019.93101-1-philmd@linaro.org>
 <20231004120019.93101-4-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20231004120019.93101-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.797, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 04/10/2023 14.00, Philippe Mathieu-Daudé wrote:
> Fix:
> 
>    net/net.c:1680:35: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
>    bool netdev_is_modern(const char *optarg)
>                                      ^
>    net/net.c:1714:38: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
>    void netdev_parse_modern(const char *optarg)
>                                         ^
>    net/net.c:1728:60: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
>    void net_client_parse(QemuOptsList *opts_list, const char *optarg)
>                                                               ^
>    /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/getopt.h:77:14: note: previous declaration is here
>    extern char *optarg;                    /* getopt(3) external variables */
>                 ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/net/net.h |  6 +++---
>   net/net.c         | 14 +++++++-------
>   2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/include/net/net.h b/include/net/net.h
> index 330d285930..2fb1c9181c 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -247,9 +247,9 @@ extern const char *host_net_devices[];
>   
>   /* from net.c */
>   extern NetClientStateList net_clients;
> -bool netdev_is_modern(const char *optarg);
> -void netdev_parse_modern(const char *optarg);
> -void net_client_parse(QemuOptsList *opts_list, const char *str);
> +bool netdev_is_modern(const char *optstr);
> +void netdev_parse_modern(const char *optstr);
> +void net_client_parse(QemuOptsList *opts_list, const char *optstr);
>   void show_netdevs(void);
>   void net_init_clients(void);
>   void net_check_clients(void);
> diff --git a/net/net.c b/net/net.c
> index 1c0bfdaa6c..c0c0cbe99e 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -1677,7 +1677,7 @@ void net_init_clients(void)
>    * Modern syntax is to be parsed with netdev_parse_modern().
>    * Traditional syntax is to be parsed with net_client_parse().
>    */
> -bool netdev_is_modern(const char *optarg)
> +bool netdev_is_modern(const char *optstr)
>   {
>       QemuOpts *opts;
>       bool is_modern;
> @@ -1689,13 +1689,13 @@ bool netdev_is_modern(const char *optarg)
>           .desc = { { } },
>       };
>   
> -    if (optarg[0] == '{') {
> +    if (optstr[0] == '{') {
>           /* This is JSON, which means it's modern syntax */
>           return true;
>       }
>   
>       opts = qemu_opts_create(&dummy_opts, NULL, false, &error_abort);
> -    qemu_opts_do_parse(opts, optarg, dummy_opts.implied_opt_name,
> +    qemu_opts_do_parse(opts, optstr, dummy_opts.implied_opt_name,
>                          &error_abort);
>       type = qemu_opt_get(opts, "type");
>       is_modern = !g_strcmp0(type, "stream") || !g_strcmp0(type, "dgram");
> @@ -1711,12 +1711,12 @@ bool netdev_is_modern(const char *optarg)
>    * netdev_parse_modern() appends to @nd_queue, whereas net_client_parse()
>    * appends to @qemu_netdev_opts.
>    */
> -void netdev_parse_modern(const char *optarg)
> +void netdev_parse_modern(const char *optstr)
>   {
>       Visitor *v;
>       NetdevQueueEntry *nd;
>   
> -    v = qobject_input_visitor_new_str(optarg, "type", &error_fatal);
> +    v = qobject_input_visitor_new_str(optstr, "type", &error_fatal);
>       nd = g_new(NetdevQueueEntry, 1);
>       visit_type_Netdev(v, NULL, &nd->nd, &error_fatal);
>       visit_free(v);
> @@ -1725,9 +1725,9 @@ void netdev_parse_modern(const char *optarg)
>       QSIMPLEQ_INSERT_TAIL(&nd_queue, nd, entry);
>   }
>   
> -void net_client_parse(QemuOptsList *opts_list, const char *optarg)
> +void net_client_parse(QemuOptsList *opts_list, const char *optstr)
>   {
> -    if (!qemu_opts_parse_noisily(opts_list, optarg, true)) {
> +    if (!qemu_opts_parse_noisily(opts_list, optstr, true)) {
>           exit(1);
>       }
>   }

Reviewed-by: Thomas Huth <thuth@redhat.com>


