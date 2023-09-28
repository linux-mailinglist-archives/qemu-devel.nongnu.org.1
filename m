Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2A97B205D
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 17:05:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlsY5-0006Zd-AB; Thu, 28 Sep 2023 11:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qlsY1-0006ZT-5Q
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 11:03:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qlsXx-0000AZ-Ln
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 11:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695913400;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=VxlTtPtgXcLDqcjTDLzruz9tmXXfO9zlYbEW1GFGgBo=;
 b=LXmchZFPTxDgo+j4AKkNI509cfmUPv3mfxUzMbSXjqOVm94P+gXYzrL/H/Wu8dJPNfdJIK
 zF4KpIY8vHuuY89CmNzVOMwOAxe2RKBqLlMXK5gdUEt4xULsBesvNoo/A5h1bWcpuFhBUv
 IuY3vLgG1JvIXC0GFw2Cet3chJqj3z4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-V59LLehUNhCK9YgkHNAuGw-1; Thu, 28 Sep 2023 11:03:16 -0400
X-MC-Unique: V59LLehUNhCK9YgkHNAuGw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4345E801779
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 15:03:16 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 670B614171B6;
 Thu, 28 Sep 2023 15:03:15 +0000 (UTC)
Date: Thu, 28 Sep 2023 16:03:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Victor Toso <victortoso@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v1 8/9] qapi: golang: Add CommandResult type to Go
Message-ID: <ZRWVsIK7lDr+WX78@redhat.com>
References: <20230927112544.85011-1-victortoso@redhat.com>
 <20230927112544.85011-9-victortoso@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230927112544.85011-9-victortoso@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Sep 27, 2023 at 01:25:43PM +0200, Victor Toso wrote:
> This patch adds a struct type in Go that will handle return values
> for QAPI's command types.
> 
> The return value of a Command is, encouraged to be, QAPI's complex
> types or an Array of those.
> 
> Every Command has a underlying CommandResult. The EmptyCommandReturn
> is for those that don't expect any data e.g: `{ "return": {} }`.
> 
> All CommandReturn types implement the CommandResult interface.
> 
> Example:
> qapi:
>     | { 'command': 'query-sev', 'returns': 'SevInfo',
>     |   'if': 'TARGET_I386' }
> 
> go:
>     | type QuerySevCommandReturn struct {
>     |     CommandId string     `json:"id,omitempty"`
>     |     Result    *SevInfo   `json:"return"`
>     |     Error     *QapiError `json:"error,omitempty"`
>     | }
> 
> usage:
>     | // One can use QuerySevCommandReturn directly or
>     | // command's interface GetReturnType() instead.
>     |
>     | input := `{ "return": { "enabled": true, "api-major" : 0,` +
>     |                        `"api-minor" : 0, "build-id" : 0,` +
>     |                        `"policy" : 0, "state" : "running",` +
>     |                        `"handle" : 1 } } `
>     |
>     | ret := QuerySevCommandReturn{}
>     | err := json.Unmarshal([]byte(input), &ret)
>     | if ret.Error != nil {
>     |     // Handle command failure {"error": { ...}}
>     | } else if ret.Result != nil {
>     |     // ret.Result.Enable == true
>     | }
> 
> Signed-off-by: Victor Toso <victortoso@redhat.com>
> ---
>  scripts/qapi/golang.py | 72 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 70 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/qapi/golang.py b/scripts/qapi/golang.py
> index 52a9124641..48ca0deab0 100644
> --- a/scripts/qapi/golang.py
> +++ b/scripts/qapi/golang.py
> @@ -40,6 +40,15 @@
>  '''
>  
>  TEMPLATE_HELPER = '''
> +type QapiError struct {

QAPIError as the name for this

> +    Class       string `json:"class"`
> +    Description string `json:"desc"`
> +}

> +
> +func (err *QapiError) Error() string {
> +    return fmt.Sprintf("%s: %s", err.Class, err.Description)
> +}

My gut feeling is that this should be just

    return err.Description

on the basis that long ago we pretty much decided that the
'Class' field was broadly a waste of time  except for a
couple of niche use cases. The error description is always
self contained and sufficient to diagnose problems, without
knowing the Class.

Keep the Class field in the struct though, as it could be
useful to check in certain cases


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


