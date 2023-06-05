Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C43DA722DF9
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 19:53:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6EO3-0004dy-4q; Mon, 05 Jun 2023 13:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6EO1-0004dA-OK
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 13:52:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6EO0-0000Pc-5Y
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 13:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685987573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mTywQk9R4xAiMOyQvlvAq/R/bLsUWAclzbkYTWyly5s=;
 b=MtrHpm196MbZx8TV21QecHfPAcyiRXETc+1aKINvCOb0muA0dY7JSOWz6RLvbN7AlpYijG
 hlW0xLrEARJL578sJbV8ArviugIjUm45ZRm0hnQvRXEac2/eXHCCkJnIcV4L9rsTMyCwae
 PUKx+eDcNdqvEPNCAZc/7eHFe7a/dfE=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-RRyMqOa2N0iUMnqKhNFjnA-1; Mon, 05 Jun 2023 13:52:52 -0400
X-MC-Unique: RRyMqOa2N0iUMnqKhNFjnA-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4f6275fdb9eso1059211e87.2
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 10:52:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685987571; x=1688579571;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mTywQk9R4xAiMOyQvlvAq/R/bLsUWAclzbkYTWyly5s=;
 b=PTLQlyldDihL1oNj5gju4UcutryzC83LvZGasf2ylMLNY8QqQnZorNH5RmVG3WPese
 Cqft/bNSmaEpDseQC5PQr+d9RzaDmmhAu5CODICeT8QfIcEsNTcLktQQFCSTPJzMPXj9
 Rn35HbnfaBz5lw4nxZKelFEJA3t98ac6a0mXFNJbmU0izualMA6yiebzJ1eu2j5WhAce
 D6jLXlI0Oxph7BfokSqpZS3Kg3Z1fZV+x8LRANcr3gSb1gNmgp9FC8fpTS27f5j4jkz/
 JH9e5FdziOsS68P9Gb/1XES5y2GIuGRUZoywYqgwmiqH865Au6BeyfSD62jNe/AeCn8i
 EGMA==
X-Gm-Message-State: AC+VfDxyXUgiETZHIPeWwjyMtXwxvU2K1KffXBUUSu1/U4AQ9bpFGBI/
 /IJrxjq07ofRl5LAKHY9nu/+bh2j3yZTnnRg/1IKBepEBpELI8pgzegRf3tybPXzHN0mZhhMlIt
 YTL1Osedlqtaf1SA=
X-Received: by 2002:a19:7506:0:b0:4f6:2bff:16b2 with SMTP id
 y6-20020a197506000000b004f62bff16b2mr1416819lfe.66.1685987570869; 
 Mon, 05 Jun 2023 10:52:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Z1gC0hc7NYFW92FRrfkwxYAuKAfivJFJHxUtFuYvmsT/+nODZUiEd37PuqVUw8to0rrL0dw==
X-Received: by 2002:a19:7506:0:b0:4f6:2bff:16b2 with SMTP id
 y6-20020a197506000000b004f62bff16b2mr1416811lfe.66.1685987570538; 
 Mon, 05 Jun 2023 10:52:50 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89?
 ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.googlemail.com with ESMTPSA id
 l2-20020a056402124200b005148e981bd3sm4086256edw.12.2023.06.05.10.52.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 10:52:50 -0700 (PDT)
Message-ID: <72e9f180-ec3b-72cd-0973-635030a2c222@redhat.com>
Date: Mon, 5 Jun 2023 19:52:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] scsi/qemu-pr-helper: Use defaults
 [get/set]_multipath_config() impl
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>
References: <20230605174146.87440-1-philmd@linaro.org>
 <20230605174146.87440-3-philmd@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230605174146.87440-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/5/23 19:41, Philippe Mathieu-Daudé wrote:
> Commit b3f1c8c413 ("qemu-pr-helper: use new libmultipath API")
> declared the two [get/set]_multipath_config() functions to
> satisfy the 'new' API. The library already provides an internal
> implementation for these helpers, exposed as weak symbols.
> Since our implementation doesn't provide much, we can default
> to the internal implementation.

This seems to be still needed in RHEL8, see 
https://www.spinics.net/lists/dm-devel/msg49851.html (March 2022).

Queued patch 1 though, thanks.

Paolo


