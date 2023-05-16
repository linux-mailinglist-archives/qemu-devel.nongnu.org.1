Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 629C6704D6C
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 14:08:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pytSp-0002bk-AK; Tue, 16 May 2023 08:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1pytSm-0002bG-MB
 for qemu-devel@nongnu.org; Tue, 16 May 2023 08:07:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1pytSk-0006X3-K6
 for qemu-devel@nongnu.org; Tue, 16 May 2023 08:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684238835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PzEsycSiYbaJrCWcUh5FSksAlYcPeOIwDZXqjanGMAE=;
 b=itHl9IlaJrDQ2ZijOuOTLdcgMFe4WmdPA5BLnOfGaP5zmNh8g1+4tJnBLq0sOG9peAqbUn
 uW4ZQHgP+Cn2Q/gBoVRVcNDpz+uJRQnJk03Auh3Py8wZvZb6oSWYT7f7V1zVydxlF+Ynz/
 9vAPpgL+PkF5c4zTQrRGVkmcFOBdRaM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-3qNVp_UrNpO2aAJxo8_VaQ-1; Tue, 16 May 2023 08:07:13 -0400
X-MC-Unique: 3qNVp_UrNpO2aAJxo8_VaQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-965fcb08b69so1460516166b.0
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 05:07:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684238829; x=1686830829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PzEsycSiYbaJrCWcUh5FSksAlYcPeOIwDZXqjanGMAE=;
 b=R4XiMwIqjWHlYnrOqsLNib+jbdl6PVhTsNoYf7doSBBcw2/PtJh+NLDA8n8R1h2q7V
 uvvd1m4LJPQvA6CCIuVHp7JknYeVyD70NyswwTMT+haUOICiPo53y7PMIH5/0OWje3a7
 7k5gPfNsYaYXg21Jzep+LXU79OUhqxA05R/fRYfGJY6wNOVOyvQWdUcr39vH/w8j9eXQ
 r7IzZV/6E0Ck20Ivxa+4AQmhoWGQBpMEd9gpbRt9QQCsTq1xbvdgFuYwZ+nvezDxaIkF
 1AvPU7gHUqGiGM52jnA0Nj0MD3ahHpQbRxtQGskT0nHNmkeEy8R0Vq5J2y1pCVhf0uE8
 a1rw==
X-Gm-Message-State: AC+VfDwT2fl7sX3hIOFpBQgu9dox5OWg56RC91CDJJpvGO1GbkvUSwmL
 CeFI+XyVONA8Y4DhfLJOx86Li7Upr3PUvzaT8ppkVruCvSXwW+F7+7AnoKrfXy8zvaIrhN1jvgF
 NOYeyye1KIRXP1oB5CVosOKg=
X-Received: by 2002:a17:907:8a04:b0:95f:de3c:6c98 with SMTP id
 sc4-20020a1709078a0400b0095fde3c6c98mr34983525ejc.58.1684238829489; 
 Tue, 16 May 2023 05:07:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ57sh5CsCQt084AmUnLHljGODZPAeFn0dAASTfe8ORrSq2ZuHRypLPXOf4SwM2uO/+Fj6otMw==
X-Received: by 2002:a17:907:8a04:b0:95f:de3c:6c98 with SMTP id
 sc4-20020a1709078a0400b0095fde3c6c98mr34983509ejc.58.1684238829162; 
 Tue, 16 May 2023 05:07:09 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 c7-20020aa7d607000000b0050bfeb15049sm8024920edr.60.2023.05.16.05.07.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 05:07:08 -0700 (PDT)
Date: Tue, 16 May 2023 14:07:07 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, Juan Quintela
 <quintela@redhat.com>
Subject: Re: [PULL v2 12/17] qapi: Rewrite parsing of doc comment section
 symbols and tags
Message-ID: <20230516140707.30f02a68@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230510081224.3588673-2-armbru@redhat.com>
References: <20230510081224.3588673-1-armbru@redhat.com>
 <20230510081224.3588673-2-armbru@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, 10 May 2023 10:12:22 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> To recognize a line starting with a section symbol and or tag, we
> first split it at the first space, then examine the part left of the
> space.  We can just as well examine the unsplit line, so do that.

this makes build fail on RHEL8.9 (Python 3.6.8)
with:
 configure --target-list=x86_64-softmmu --disable-docs
 make -j32
 ...
 /usr/bin/python3 /builds/qemu/scripts/qapi-gen.py -o qapi -b ../../builds/qemu/qapi/qapi-schema.json
Traceback (most recent call last):                                               
  File "/builds/qemu/scripts/qapi-gen.py", line 16, in <module>                  
    from qapi import main                                                        
  File "/builds/qemu/scripts/qapi/main.py", line 14, in <module>                 
    from .commands import gen_commands                                           
  File "/builds/qemu/scripts/qapi/commands.py", line 24, in <module>             
    from .gen import (                                                           
  File "/builds/qemu/scripts/qapi/gen.py", line 32, in <module>                  
    from .schema import (                                                        
  File "/builds/qemu/scripts/qapi/schema.py", line 31, in <module>               
    from .expr import check_exprs                                                
  File "/builds/qemu/scripts/qapi/expr.py", line 46, in <module>                 
    from .parser import QAPIExpression                                           
  File "/builds/qemu/scripts/qapi/parser.py", line 449, in <module>              
    class QAPIDoc:                                                               
  File "/builds/qemu/scripts/qapi/parser.py", line 563, in QAPIDoc               
    def _match_at_name_colon(string: str) -> re.Match:                           
AttributeError: module 're' has no attribute 'Match'   



> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Message-Id: <20230428105429.1687850-13-armbru@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> [Work around lack of walrus operator in Python 3.7 and older]
> ---
>  scripts/qapi/parser.py | 55 +++++++++++++++++++++---------------------
>  1 file changed, 27 insertions(+), 28 deletions(-)
> 
> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> index ddc14ceaba..a4ff9b6dbf 100644
> --- a/scripts/qapi/parser.py
> +++ b/scripts/qapi/parser.py
> @@ -560,12 +560,12 @@ def end_comment(self) -> None:
>          self._switch_section(QAPIDoc.NullSection(self._parser))
>  
>      @staticmethod
> -    def _is_section_tag(name: str) -> bool:
> -        return name in ('Returns:', 'Since:',
> -                        # those are often singular or plural
> -                        'Note:', 'Notes:',
> -                        'Example:', 'Examples:',
> -                        'TODO:')
> +    def _match_at_name_colon(string: str) -> re.Match:
> +        return re.match(r'@([^:]*): *', string)
> +
> +    @staticmethod
> +    def _match_section_tag(string: str) -> re.Match:
> +        return re.match(r'(Returns|Since|Notes?|Examples?|TODO): *', string)
>  
>      def _append_body_line(self, line: str) -> None:
>          """
> @@ -581,7 +581,6 @@ def _append_body_line(self, line: str) -> None:
>  
>          Else, append the line to the current section.
>          """
> -        name = line.split(' ', 1)[0]
>          # FIXME not nice: things like '#  @foo:' and '# @foo: ' aren't
>          # recognized, and get silently treated as ordinary text
>          if not self.symbol and not self.body.text and line.startswith('@'):
> @@ -595,12 +594,12 @@ def _append_body_line(self, line: str) -> None:
>                      self._parser, "name required after '@'")
>          elif self.symbol:
>              # This is a definition documentation block
> -            if name.startswith('@') and name.endswith(':'):
> +            if self._match_at_name_colon(line):
>                  self._append_line = self._append_args_line
>                  self._append_args_line(line)
>              elif line == 'Features:':
>                  self._append_line = self._append_features_line
> -            elif self._is_section_tag(name):
> +            elif self._match_section_tag(line):
>                  self._append_line = self._append_various_line
>                  self._append_various_line(line)
>              else:
> @@ -621,16 +620,16 @@ def _append_args_line(self, line: str) -> None:
>          Else, append the line to the current section.
>  
>          """
> -        name = line.split(' ', 1)[0]
> -
> -        if name.startswith('@') and name.endswith(':'):
> +        match = self._match_at_name_colon(line)
> +        if match:
>              # If line is "@arg:   first line of description", find
>              # the index of 'f', which is the indent we expect for any
>              # following lines.  We then remove the leading "@arg:"
>              # from line and replace it with spaces so that 'f' has the
>              # same index as it did in the original line and can be
>              # handled the same way we will handle following lines.
> -            indent = must_match(r'@\S*:\s*', line).end()
> +            name = match.group(1)
> +            indent = match.end()
>              line = line[indent:]
>              if not line:
>                  # Line was just the "@arg:" header
> @@ -638,8 +637,8 @@ def _append_args_line(self, line: str) -> None:
>                  indent = -1
>              else:
>                  line = ' ' * indent + line
> -            self._start_args_section(name[1:-1], indent)
> -        elif self._is_section_tag(name):
> +            self._start_args_section(name, indent)
> +        elif self._match_section_tag(line):
>              self._append_line = self._append_various_line
>              self._append_various_line(line)
>              return
> @@ -656,16 +655,16 @@ def _append_args_line(self, line: str) -> None:
>          self._append_freeform(line)
>  
>      def _append_features_line(self, line: str) -> None:
> -        name = line.split(' ', 1)[0]
> -
> -        if name.startswith('@') and name.endswith(':'):
> +        match = self._match_at_name_colon(line)
> +        if match:
>              # If line is "@arg:   first line of description", find
>              # the index of 'f', which is the indent we expect for any
>              # following lines.  We then remove the leading "@arg:"
>              # from line and replace it with spaces so that 'f' has the
>              # same index as it did in the original line and can be
>              # handled the same way we will handle following lines.
> -            indent = must_match(r'@\S*:\s*', line).end()
> +            name = match.group(1)
> +            indent = match.end()
>              line = line[indent:]
>              if not line:
>                  # Line was just the "@arg:" header
> @@ -673,8 +672,8 @@ def _append_features_line(self, line: str) -> None:
>                  indent = -1
>              else:
>                  line = ' ' * indent + line
> -            self._start_features_section(name[1:-1], indent)
> -        elif self._is_section_tag(name):
> +            self._start_features_section(name, indent)
> +        elif self._match_section_tag(line):
>              self._append_line = self._append_various_line
>              self._append_various_line(line)
>              return
> @@ -698,13 +697,13 @@ def _append_various_line(self, line: str) -> None:
>  
>          Else, append the line to the current section.
>          """
> -        name = line.split(' ', 1)[0]
> -
> -        if name.startswith('@') and name.endswith(':'):
> +        match = self._match_at_name_colon(line)
> +        if match:
>              raise QAPIParseError(self._parser,
> -                                 "'%s' can't follow '%s' section"
> -                                 % (name, self.sections[0].name))
> -        if self._is_section_tag(name):
> +                                 "'@%s:' can't follow '%s' section"
> +                                 % (match.group(1), self.sections[0].name))
> +        match = self._match_section_tag(line)
> +        if match:
>              # If line is "Section:   first line of description", find
>              # the index of 'f', which is the indent we expect for any
>              # following lines.  We then remove the leading "Section:"
> @@ -719,7 +718,7 @@ def _append_various_line(self, line: str) -> None:
>                  indent = 0
>              else:
>                  line = ' ' * indent + line
> -            self._start_section(name[:-1], indent)
> +            self._start_section(match.group(1), indent)
>  
>          self._append_freeform(line)
>  


